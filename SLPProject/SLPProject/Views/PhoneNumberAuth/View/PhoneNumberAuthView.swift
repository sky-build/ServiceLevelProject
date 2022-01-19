//
//  PhoneNumberAuthView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit

class PhoneNumberAuthView: UIView, FetchViews {
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    let phoneNumberTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "전화번호를 입력하세요"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let authMessageButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("인증 문자 받기", for: .normal)
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
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authMessageButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
