//
//  ExplainLabel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit

class ExplainLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = .Display1_R20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
