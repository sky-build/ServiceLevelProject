//
//  PhoneNumberAuthView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit
import SnapKit

class PhoneNumberAuthView: UIView, FetchViews {
    
    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let phoneNumberTextField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.textField.placeholder = "전화번호를 입력하세요"
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    let authMessageButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("인증 문자 받기", for: .normal)
        button.titleLabel?.font = .Body3_R14
        button.backgroundColor = .slpGray6
        return button
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
        self.addSubview(explainLabel)
        self.addSubview(phoneNumberTextField)
        self.addSubview(authMessageButton)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(74)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(77)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authMessageButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(85)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
