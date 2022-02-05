//
//  APIService.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/24.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxRelay

private enum UserEnum: Int {
    case noConnectinon = 0   // enum 처리
    case success = 200
    case noRegister = 201
    case invalidNickname = 202
    case firebaseTokenError = 401
    case alreadyWithdraw = 406
    case serverError = 500
    case clientError = 501
}

private enum UserURL: String {
    case user = "user"
    case withdraw = "user/withdraw"
    case updateFCMToken = "user/update_fcm_token"
    case updateMyPage = "user/update/mypage"
}

extension UserURL {
    var url: URL {
        URL(string: "http://test.monocoding.com:35484/" + self.rawValue)!
    }
}

class UserAPI {
    
    // 연산 프로퍼티 사용해야 idToken값이 지속적으로 변경됨
    private var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": FirebaseToken.shared.idToken
        ]
    }
    
    // API상태 업데이트
    let state = PublishRelay<UserAPIResult>()
    let userResult = PublishRelay<UserInformation>()

    private var disposeBag = DisposeBag()
    
    // 기본 코드
    fileprivate func baseUserAPIRequest(method: HTTPMethod, url: URL, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (Data?, UserEnum) -> Void) {
        if NetworkMonitor.shared.isConnected {
            RxAlamofire.requestData(method, url, parameters: parameters, headers: header)
                .debug()
                .subscribe { (header, data) in
                    // APIState를 Enum으로 변경
                    let apiState = UserEnum(rawValue: header.statusCode)!
                    
                    completion(data, apiState)
                }
                .disposed(by: disposeBag)
        } else {
            completion(nil, .noConnectinon)
        }

    }
    
    // 유저가 이미 있는지 확인
    func checkUserExist() {
        baseUserAPIRequest(method: .get, url: UserURL.user.url, parameters: nil, header: header) { [self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(UserInformation.self, from: data)
                    // 여기에서 값을 전달
                    userResult.accept(decodeData)
                    // 그리고 구독하라고 설정
                    state.accept(.alreadyRegister)
                    
                    // FCM 토큰이 지금 내것이랑 다르다면 별도로 처리
                    if FirebaseToken.shared.fcmToken != decodeData.fcMtoken {
                        // FCM토큰 업데이트
                        FirebaseToken.shared.updateFCMToken {
                            // 다시 호출
                            updateFCMToken()
                        }
                    }
                } catch {
                    // 디코딩 실패
                    state.accept(.failDecode)
                }
            case .noRegister:
                // 회원가입페이지로 전송
                print(apiState.rawValue)
                // 다음화면으로 이동
                state.accept(.noRegister)
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                print(apiState.rawValue)
                FirebaseToken.shared.updateIDToken {
                    checkUserExist()
                }
            case .serverError:
                // 서버 오류
                print(apiState.rawValue)
            case .clientError:
                // 클라이언트 오류
                print(apiState.rawValue)
            case .noConnectinon:
                state.accept(.noConnection)
            default:
                print("안됨")
            }
        }
    }
    
    // 회원가입
    func registerUser() {
        let user = UserModel.shared
        var parameters: Parameters {
            [
                "phoneNumber" : "+82" + user.phoneNumber.value,
                "FCMtoken" : FirebaseToken.shared.fcmToken,
                "nick": user.nickname.value,
                "birth": "\(user.birthday.value)",
                "email": user.email.value,
                "gender" : user.gender.value.rawValue
            ]
        }
        
        baseUserAPIRequest(method: .post, url: UserURL.user.url, parameters: parameters, header: header) { [self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                print("성공")
                state.accept(.success)
            case .invalidNickname:
                // 부적절한 닉네임
                print("부적절한 닉네임")
                state.accept(.invalidNickname)
            case .noRegister:
                // 회원가입페이지로 전송
                state.accept(.alreadyRegister)
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    registerUser()
                }
            case .serverError: break
                // 서버 오류
            case .clientError: break
                // 클라이언트 오류
            default:
                print("안됨")
            }
        }
    }
    
    // 회원탈퇴
    func withdrawUser() {
        baseUserAPIRequest(method: .post, url: UserURL.withdraw.url, parameters: nil, header: header) { [weak self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                print("성공")
                self?.state.accept(.successDeRegister)
            case .alreadyWithdraw:
                print("이미 회원탈퇴함")
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.withdrawUser()
                }
            case .serverError: break
                // 서버 오류
            default:
                print(apiState.rawValue)
            }
        }
    }
    
    // 회원정보 갱신
    func updateMyPage() {
        var parameters: Parameters {
            [
                "searchable" : InformationManagementModel.shared.toggleState.value,
                "ageMin" : InformationManagementModel.shared.age.value[0],
                "ageMax" : InformationManagementModel.shared.age.value[1],
                "gender" : InformationManagementModel.shared.gender.value.rawValue,
                "hobby" : InformationManagementModel.shared.hobby.value
            ]
        }
        
        baseUserAPIRequest(method: .post, url: UserURL.updateMyPage.url, parameters: parameters, header: header) { [weak self] (data, apiState) in
            switch apiState {
            case .noConnectinon:
                print("연결안됨")
            case .success:
                print("success")
                self?.state.accept(.success)
            case .noRegister:
                print("noRegister")
            case .invalidNickname:
                print("invalidNickname")
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.updateMyPage()
                }
                print("firebaseTokenError")
            case .alreadyWithdraw:
                print("alreadyWithdraw")
            case .serverError:
                print("serverError")
            case .clientError:
                print("clientError")
            }
        }
    }
    
    // FCM 토큰 갱신
    func updateFCMToken() {
        // 연산 프로퍼티
        var parameters: Parameters {
            [
                "FCMToken": FirebaseToken.shared.fcmToken
            ]
        }
        
        baseUserAPIRequest(method: .put, url: UserURL.updateFCMToken.url, parameters: parameters, header: header) { [weak self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                print("성공")
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.updateFCMToken()
                }
            case .serverError: break
                // 서버 오류
            default:
                print("defualt")
            }
        }
    }
}
