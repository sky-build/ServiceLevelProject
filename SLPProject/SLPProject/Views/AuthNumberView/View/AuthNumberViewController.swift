//
//  AuthNumberViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit

class AuthNumberViewController: BaseViewController {
    
    let mainView = AuthNumberView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
