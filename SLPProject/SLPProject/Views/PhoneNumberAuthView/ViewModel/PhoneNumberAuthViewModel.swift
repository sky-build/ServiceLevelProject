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
        PhoneAuthProvider.provider()
          .verifyPhoneNumber("+82\(phoneNumber.value)", uiDelegate: nil) { verificationID, error in
              if let error = error {
                  print(error)
                  print(error.localizedDescription.description.endIndex)
                  print(error.localizedDescription.endIndex.hashValue)
                  print(error.localizedDescription.hashValue)
                  // 많이 보냈을 때 오류 어떻게 아는지?
                  completion(.unknownError)
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
