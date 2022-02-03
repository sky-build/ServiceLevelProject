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
                self.backgroundColor = .slpGreen
                self.tintColor = .slpWhite
            } else {
                self.backgroundColor = .white
                self.tintColor = .slpBlack
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = .Body3_R14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
