//
//  CustomTextView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit
import SnapKit

class CustomTextFieldView: UIView, FetchViews {
    
    let textField: CustomTextField = {
        let textField = CustomTextField()
        return textField
    }()
    
    let stateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slpGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(textField)
        self.addSubview(stateLine)
    }
    
    func makeConstraints() {
        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(5)
        }
        
        stateLine.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
    
}
