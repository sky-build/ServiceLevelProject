//
//  UserViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/24.
//

import Foundation
import RxRelay
import FirebaseAuth
import UIKit

class UserViewModel {
    
    let userAPI = UserAPI()
    
    let user = UserModel.shared
    
    var nicknameViewModel: UIViewController?
    
    // 휴대폰 인증 전송 코드
    func sendPhoneAuthorization(completion: @escaping (PhoneNumberAuthStatus) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(user.phoneNumber.value)", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    
                    // AuthErrorCode로 변환
                    let state = AuthErrorCode(rawValue: error._code)
                    
                    switch state {
                    case .tooManyRequests:
                        // 만약 에러코드가 tooManyRequests(17010)이라면 tooManyRequests 전달
                        completion(.tooManyRequests)
                    default:
                        completion(.unknownError)
                    }
                    
                    return
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
                FirebaseToken.shared.updateIDToken {}
                UserDefaults.standard.set(verificationID, forKey: "verificationID")
                completion(.success)
            }
    }
    
    // 전화번호로 auth토큰 인증하는것
    func authToken(completion: @escaping (PhoneNumberAuthStatus) -> Void) {
        let verificationID = UserDefaults.standard.string(forKey: "verificationID")!
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: user.authNumber.value
        )
        
        Auth.auth().signIn(with: credential) { [self] authResult, error in
            if let error = error {
                // AuthErrorCode로 변환
                let state = AuthErrorCode(rawValue: error._code)
                
                switch state {
                case .invalidVerificationCode:  // 인증번호가 틀렸을 경우
                    completion(.invalidVerificationCode)
                default:
                    completion(.unknownError)
                }
                return
            }
            // 인증하고 UserDefault 업데이트
            UserDefaultValues.registerState = .phoneAuth
            // User is signed in
            // 유저인지 체크
            userAPI.getUser()
            completion(.success)
        }
    }
}
