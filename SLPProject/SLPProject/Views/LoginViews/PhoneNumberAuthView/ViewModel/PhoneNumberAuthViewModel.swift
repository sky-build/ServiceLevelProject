//
//  PhoneNumberAuthViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import Foundation
import RxRelay
import FirebaseAuth

class PhoneNumberAuthViewModel {
    var phoneNumber = BehaviorRelay<String>(value: "")
    
    // 휴대폰 인증 전송 코드
    func sendPhoneAuthorization(completion: @escaping (PhoneNumberAuthStatus) -> Void) {
        print("phoneNumber = ", phoneNumber.value)
        PhoneAuthProvider.provider()
          .verifyPhoneNumber("+82\(phoneNumber.value)", uiDelegate: nil) { verificationID, error in
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
              print("메시지로 전송")
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              completion(.success)
          }
    }
}
