//
//  AuthNumberViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/21.
//

import Foundation
import RxRelay
import FirebaseAuth

class AuthNumberViewModel {
    var authNumber = BehaviorRelay<String>(value: "")
    var toastText: String?
    
    func authToken(completion: @escaping (PhoneNumberAuthStatus) -> Void) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: authNumber.value
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                let authError = error as NSError
                print(authError.description)
                completion(.unknownError)
                return
            }
            // User is signed in
            // ...
            print("인증 성공")
            completion(.success)
        }
    }
}
