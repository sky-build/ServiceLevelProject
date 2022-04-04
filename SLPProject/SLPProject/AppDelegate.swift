//
//  AppDelegate.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        // FCM토큰 업데이트
//        Messaging.messaging().delegate = self
//        DispatchQueue.global().async {
//            FirebaseToken.shared.updateFCMToken {
//                print("FCM토큰 발급")
//            }
//        }
        
        // 네트워크 모니터링 설정
        NetworkMonitor.shared.startMonitoring()
        
        
        // UserDefaults 초기화
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
        
        // 이전 idToken을 넣어놓고 토큰 업데이트 테스트
        FirebaseToken.shared.idToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjNhYTE0OGNkMDcyOGUzMDNkMzI2ZGU1NjBhMzVmYjFiYTMyYTUxNDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2VzYWMtMSIsImF1ZCI6InNlc2FjLTEiLCJhdXRoX3RpbWUiOjE2NDMxODU2NjAsInVzZXJfaWQiOiJlMzBjT0lZd3g1TWl3Y2JCQkxLamZnZ3V5eDYzIiwic3ViIjoiZTMwY09JWXd4NU1pd2NiQkJMS2pmZ2d1eXg2MyIsImlhdCI6MTY0MzIwOTczOSwiZXhwIjoxNjQzMjEzMzM5LCJwaG9uZV9udW1iZXIiOiIrODIxMDQ0NDQ0NDQ0IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrODIxMDQ0NDQ0NDQ0Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.zGJ8Twksg3o0ew18-y2WNv2WP19IvmDPgsTFKQlrIShOwQoXA9mrfx8FV220E-SkK7wWfl31H27i53ouMy4KQ6UTxuNe9foT1ngFTQEmvZAk9xQtc9Bdb5aI8drp9k-nWXXq0HLb-wkcLJIkHvM9vh99S6ruhpdcDqfw3FT16F8xIYp73tvsSQ_QZ0BKzs63tv1lEpVUtdf3wHFEAOeWQttbI07CE0PvJfjxTnTo04QORpUJRMxihhLd60ek0Sg0v6CxWAt7YLJCWibG3coO-ZcLU4xGVS9u8AehUuc9VtmOLMi3JZu6kxq3pk3wC21Id8p833DuRZtIcFijOEyBug"
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(
                types: [.alert, .sound, .badge],
                categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        SocketIOManager.shared.closeConnection()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketIOManager.shared.establishConnection()
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        UserDefaults.standard.set(fcmToken, forKey: FirebaseToken.shared.fcmToken)
//        FirebaseToken.shared.fcmToken = fcmToken!
//        sleep(10)
        UserAPI().updateFCMToken()
        print("Firebase registeration token: \(String(describing: fcmToken))")
        let dataDict: [String: String] = ["token": fcmToken ?? "" ]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}
