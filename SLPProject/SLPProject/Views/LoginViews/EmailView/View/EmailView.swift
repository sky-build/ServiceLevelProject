//
//  EmailView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class EmailView: UIView, FetchViews {
    
    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "이메일을 입력해 주세요"
        label.textAlignment = .center
        return label
    }()
    
    let subExplainLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        label.textAlignment = .center
        label.textColor = .slpGray7
        return label
    }()
    
    let emailTextField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.textField.placeholder = "이메일을 입력하세요"
        return view
    }()
    
    let nextButton: CustomNextButton = {
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
        self.addSubview(subExplainLabel)
        self.addSubview(emailTextField)
        self.addSubview(nextButton)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(57)
        }
        
        subExplainLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(subExplainLabel.snp.bottom).offset(63)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(72)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

}
