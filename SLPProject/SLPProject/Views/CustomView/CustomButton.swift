//
//  CustomButton.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit

class CusomButton: UIButton {
    
    var buttonState = false {
        didSet {
            if buttonState {
                layer.borderWidth = 0
                backgroundColor = .slpGreen
                setTitleColor(.slpWhite, for: .normal)
            } else {
                layer.borderWidth = 1
                backgroundColor = .white
                setTitleColor(.slpBlack, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.slpGray6.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .Body3_R14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
