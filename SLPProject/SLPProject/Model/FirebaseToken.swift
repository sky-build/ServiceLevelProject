//
//  FirebaseToken.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseMessaging

class FirebaseToken {
    
    static let shared = FirebaseToken()
    
    var idToken: String {
        get {
            UserDefaults.standard.string(forKey: "idToken") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "idToken")
        }
    }
    
    var fcmToken: String {
        get {
            UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
        }
    }
    
    func updateIDToken(completion: @escaping () -> Void) {
        let currentUser = Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { token, error in
            if let error = error {
                print(error)
                return;
            }
            
            // Send token to your backend via HTTPS
            // ...
            print("ID token: \(token!)")
            self.idToken = token!
            completion()
        }
    }
    
    func updateFCMToken(completion: @escaping () -> Void) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                // fcm토큰 넣어줌
                print(token)
                self.fcmToken = token
                completion()
            }
        }
    }
}
