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
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = navigationController
    }
    
    // rootView를 ViewController로 바꿔줌
    func changeRootView(_ viewController: UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = viewController
    }
}
