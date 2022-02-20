//
//  ChatTextView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit
import GrowingTextView

enum SendButtonEnable {
    case enable
    case disable
}

class ChatTextView: UIView, FetchViews {
    
    let textView: GrowingTextView = {
        let view = GrowingTextView()
        view.backgroundColor = .clear
//        view.maxLength = 140
        view.font = .Title4_R14
        view.trimWhiteSpaceWhenEndEditing = false
        view.placeholder = "메시지를 입력하세요"
        view.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        view.minHeight = 40
        view.maxHeight = 70
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    var sendButtonState: SendButtonEnable = .disable {
        didSet {
            switch sendButtonState {
            case .disable:
                sendButton.setImage(UIImage(named: "sendButtonDisable"), for: .normal)
            case .enable:
                sendButton.setImage(UIImage(named: "sendButtonEnable"), for: .normal)
            }
        }
    }
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendButtonDisable"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
        
        self.backgroundColor = .slpGray1
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [textView, sendButton].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        textView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(sendButton.snp.leading).inset(-10)
            $0.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
    }
    
}
