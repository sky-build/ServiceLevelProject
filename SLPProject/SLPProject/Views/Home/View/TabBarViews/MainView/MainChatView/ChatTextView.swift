//
//  ChatTextView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit
import GrowingTextView

class ChatTextView: UIView, FetchViews {
    
    let textView: GrowingTextView = {
        let view = GrowingTextView()
        view.backgroundColor = .clear
//        view.maxLength = 140
        view.trimWhiteSpaceWhenEndEditing = false
        view.placeholder = "Say something..."
        view.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        view.minHeight = 30
        view.maxHeight = 57.666666666666665
//        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendButtonEnable"), for: .normal)
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
            $0.top.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(sendButton.snp.leading).inset(-10)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
    }
    
}
