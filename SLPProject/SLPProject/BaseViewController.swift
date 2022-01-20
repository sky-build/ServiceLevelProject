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
        
        // 배경 설정
        view.backgroundColor = .white
        
        // 백버튼 설정
        navigationController?.setBackButton()
    }
    
}
