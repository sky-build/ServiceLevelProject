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
    case alreadyRegister = 201
    case invalidNickname = 202
    case firebaseTokenError = 401
    case userInformationError = 406
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
        URL(string: BaseAPI.baseURL + self.rawValue)!
    }
}

class UserAPI {
    
    // API상태 업데이트
    let state = PublishRelay<UserAPIResult>()
    let userResult = PublishRelay<UserInformation>()

    private var disposeBag = DisposeBag()
    
    // 기본 코드
    fileprivate func baseUserAPIRequest(method: HTTPMethod, url: URL, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (Data?, UserEnum) -> Void) {
        if NetworkMonitor.shared.isConnected {
            RxAlamofire.requestData(method, url, parameters: parameters, headers: BaseAPI.header)
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
    
    // 유저정보 받아오는 코드
    func getUser() {
        baseUserAPIRequest(method: .get, url: UserURL.user.url, parameters: nil, header: BaseAPI.header) { [self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(UserInformation.self, from: data)
                    // 모델에 값 변경해줌
                    UserModel.shared.fetchData(decodeData)
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
            case .alreadyRegister:
                UserDefaultValues.registerState = .alreadyRegister
            case .userInformationError:
                // 회원가입페이지로 전송
                state.accept(.noRegister)
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    getUser()
                }
            case .noConnectinon:
                state.accept(.noConnection)
            default:
                print(apiState.rawValue)
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
        
        baseUserAPIRequest(method: .post, url: UserURL.user.url, parameters: parameters, header: BaseAPI.header) { [self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                state.accept(.success)
                UserDefaultValues.registerState = .alreadyRegister
            case .invalidNickname:
                // 부적절한 닉네임
                state.accept(.invalidNickname)
            case .alreadyRegister:
                // 회원가입페이지로 전송
                state.accept(.alreadyRegister)
                UserDefaultValues.registerState = .alreadyRegister
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    registerUser()
                }
            default:
                print(apiState.rawValue)
            }
        }
    }
    
    // 회원탈퇴
    func withdrawUser() {
        baseUserAPIRequest(method: .post, url: UserURL.withdraw.url, parameters: nil, header: BaseAPI.header) { [weak self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                UserDefaultValues.registerState = .beginner
                self?.state.accept(.successDeRegister)
            case .userInformationError:
                print("이미 회원탈퇴함")
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.withdrawUser()
                }
            default:
                print(apiState.rawValue)
            }
        }
    }
    
    // 회원정보 갱신
    func updateMyPage() {
        var parameters: Parameters {
            [
                "searchable" : UserModel.shared.toggleState.value,
                "ageMin" : UserModel.shared.age.value[0],
                "ageMax" : UserModel.shared.age.value[1],
                "gender" : UserModel.shared.gender.value.rawValue,
                "hobby" : UserModel.shared.hobby.value
            ]
        }
        
        baseUserAPIRequest(method: .post, url: UserURL.updateMyPage.url, parameters: parameters, header: BaseAPI.header) { [weak self] (data, apiState) in
            switch apiState {
            case .success:
                self?.state.accept(.success)
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.updateMyPage()
                }
            default:
                print(apiState.rawValue)
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
        
        baseUserAPIRequest(method: .put, url: UserURL.updateFCMToken.url, parameters: parameters, header: BaseAPI.header) { [weak self] (data, apiState) in
            switch apiState {
            case .firebaseTokenError:
                // 토큰 재발급, 재시도
                FirebaseToken.shared.updateIDToken {
                    self?.updateFCMToken()
                }
            default:
                print(apiState.rawValue)
            }
        }
    }
}
