//
//  AuthNumberView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit
import SnapKit

class AuthNumberView: UIView, FetchViews {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textColor = .slpGreen
        return label
    }()
    
    let timeButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("재전송", for: .normal)
        button.titleLabel?.font = .Body3_R14
        return button
    }()

    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "인증번호가 문자로 전송되었어요"
        label.textAlignment = .center
        return label
    }()
    
    let messageTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 소모 20초"
        label.textAlignment = .center
        label.textColor = .slpGray7
        return label
    }()
    
    let numberTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.textField.placeholder = "인증번호 입력"
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    let authMessageButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("인증하고 시작하기", for: .normal)
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
        self.addSubview(timeLabel)
        self.addSubview(timeButton)
        self.addSubview(explainLabel)
        self.addSubview(messageTimeLabel)
        self.addSubview(numberTextFieldView)
        self.addSubview(authMessageButton)
    }
    
    func makeConstraints() {
        timeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(numberTextFieldView)
            $0.width.equalTo(72)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(numberTextFieldView)
            $0.trailing.equalTo(numberTextFieldView.snp.trailing).inset(10)
        }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(57)
        }
        
        messageTimeLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        numberTextFieldView.snp.makeConstraints {
            $0.top.equalTo(messageTimeLabel.snp.bottom).offset(76)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(timeButton.snp.leading).inset(-16)
        }
        
        authMessageButton.snp.makeConstraints {
            $0.top.equalTo(numberTextFieldView.snp.bottom).offset(84)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
