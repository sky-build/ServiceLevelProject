//
//  NicknameView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit

class NicknameView: UIView, FetchViews {
    
    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "닉네임을 입력해주세요"
        label.textAlignment = .center
        return label
    }()
    
    let nicknameTextField: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.textField.placeholder = "10자 이내로 입력"
        return view
    }()
    
    let nextButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("다음", for: .normal)
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
        self.addSubview(nicknameTextField)
        self.addSubview(nextButton)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(74)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(77)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(85)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
