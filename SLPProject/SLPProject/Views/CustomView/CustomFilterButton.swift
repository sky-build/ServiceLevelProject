//
//  CustomFilterButton.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit

class CustomFilterButton: UIButton {
    
    var buttonState = false {
        didSet {
            if buttonState {
                backgroundColor = .slpGreen
                setTitleColor(.slpWhite, for: .normal)
                titleLabel?.font = .Title3_M14
            } else {
                backgroundColor = .white
                setTitleColor(.slpBlack, for: .normal)
                titleLabel?.font = .Title4_R14
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
