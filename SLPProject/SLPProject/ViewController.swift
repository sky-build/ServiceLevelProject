//
//  ViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        button.backgroundColor = .black
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(50)
        }
    }


}

