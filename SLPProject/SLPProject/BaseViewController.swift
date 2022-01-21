//
//  BaseViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        setBackgroundColor()
        
        // 백버튼 색상 변경
        setNavigationBarBackButton()
    }
    
    // 배경색 설정
    func setBackgroundColor() {
        // 배경 설정
        view.backgroundColor = .white
    }
    
    // 백버튼 색상 변경
    func setNavigationBarBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .slpBlack
    }
}
