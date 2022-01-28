//
//  UIViewController+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/25.
//

import UIKit

extension UIViewController {
    // rootView를 바꿔주기
    func changeRootView(_ viewController: UIViewController) {
        // Root 뷰컨트롤러를 바꿔줌
        let rootVC = UINavigationController(rootViewController: viewController)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = rootVC
    }
}
