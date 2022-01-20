//
//  CustomTextField.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .white
        self.addLeftPadding()
        self.font = .Title4_R14
        
        self.snp.makeConstraints {
            $0.height.equalTo(22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
