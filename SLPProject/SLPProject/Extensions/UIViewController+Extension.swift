//
//  UIViewController+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/25.
//

import UIKit

extension UIViewController {
    // rootView를 NavigationController로 바꿔줌
    func changeRootView(_ navigationController: UINavigationController) {
        let rootVC = UINavigationController(rootViewController: navigationController)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = rootVC
    }
    
    // rootView를 ViewController로 바꿔줌
    func changeRootView(_ viewController: UIViewController) {
        let rootVC = viewController
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = rootVC
    }
}
