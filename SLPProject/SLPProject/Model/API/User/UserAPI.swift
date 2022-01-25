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
}

extension UserURL {
    var url: URL {
        URL(string: "http://test.monocoding.com:35484/" + self.rawValue)!
    }
}

class UserAPI {
    
    let header: HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded",
        "idtoken": FirebaseToken.shared.idToken
    ]
    
    // API상태 업데이트
    let state = PublishRelay<Bool>()
    let userResult = PublishRelay<UserInformation>()
    
    private var disposeBag = DisposeBag()
    
    // 기본 코드
    fileprivate func baseAlamofire(method: HTTPMethod, url: URL, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (Data?, UserEnum) -> Void) {
        RxAlamofire.requestData(method, url, parameters: parameters, headers: header)
            .debug()
            .subscribe { (header, data) in
                // APIState를 Enum으로 변경
                let apiState = UserEnum(rawValue: header.statusCode)!
                
                completion(data, apiState)
            }
            .disposed(by: disposeBag)
    }
    
    // 유저가 이미 있는지 확인
    func checkUserExist() {
        baseAlamofire(method: .get, url: UserURL.user.url, parameters: nil, header: header) { [self] (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(UserInformation.self, from: data)
                    // 여기에서 값을 전달
                    userResult.accept(decodeData)
                    // 그리고 구독하라고 설정
                    state.accept(true)
                } catch {
                    print("디코딩 실패")
                    state.accept(false)
                }
            case .noRegister: break
                // 회원가입페이지로 전송
            case .firebaseTokenError: break
                // 토큰 재발급, 재시도
            case .serverError: break
                // 서버 오류
            case .clientError: break
                // 클라이언트 오류
            default:
                print("안됨")
            }
        }
    }
    
    // 회원가입
    func registerUser() {
        let user = UserModel.shared
        let parameters: Parameters = [
            "phoneNumber" : "+82" + user.phoneNumber.value,
            "FCMtoken" : FirebaseToken.shared.fcmToken,
            "nick": user.nickname.value,
            "birth": "\(user.birthday.value)",
            "email": user.email.value,
            "gender" : user.gender.value.rawValue
        ]
        
        baseAlamofire(method: .post, url: UserURL.user.url, parameters: parameters, header: header) { (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                print("성공")
            case .invalidNickname:
                // 부적절한 닉네임
                print("부적절한 닉네임")
            case .noRegister: break
                // 회원가입페이지로 전송
            case .firebaseTokenError: break
                // 토큰 재발급, 재시도
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
        baseAlamofire(method: .post, url: UserURL.user.url, parameters: nil, header: header) { (data, apiState) in
            switch apiState {
            case .success:  // 성공했을때
                print("성공")
            case .alreadyWithdraw:
                print("이미 회원탈퇴함")
            case .firebaseTokenError: break
                // 토큰 재발급, 재시도
            case .serverError: break
                // 서버 오류
            default:
                print("defualt")
            }
        }
    }
    
}
