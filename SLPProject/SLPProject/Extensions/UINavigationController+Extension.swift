//
//  UINavigationBar+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit

extension UINavigationController {
    func setBackButton() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        
        self.navigationBar.topItem?.title = ""
        self.navigationBar.tintColor = .black
    }
}
