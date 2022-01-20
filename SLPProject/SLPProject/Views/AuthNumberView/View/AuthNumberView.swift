//
//  AuthNumberView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit
import SnapKit

class AuthNumberView: UIView, FetchViews {

    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "인증번호가 문자로 전송되었어요"
        return label
    }()
    
    let messageTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 소모 20초"
        label.textColor = .slpGray7
        return label
    }()
    
    let numberTextField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.textField.placeholder = "인증번호 입력"
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    let authMessageButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("인증하고 시작하기", for: .normal)
        button.titleLabel?.font = .Body3_R14
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
        self.addSubview(messageTimeLabel)
        self.addSubview(numberTextField)
        self.addSubview(authMessageButton)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(57)
        }
        
        messageTimeLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(messageTimeLabel.snp.bottom).offset(76)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        authMessageButton.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset(84)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    

}
