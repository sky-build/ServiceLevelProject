//
//  ChatSettingView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/27.
//

import UIKit

class ChatSettingView: UIView, FetchViews {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    let reportView: ChatSettingSubView = {
        let view = ChatSettingSubView()
        view.text.text = "신고 하기"
        view.image.image = UIImage(named: "report")
        return view
    }()
    
    let cancelPromiseView: ChatSettingSubView = {
        let view = ChatSettingSubView()
        view.text.text = "약속 취소"
        view.image.image = UIImage(named: "cancel_match")
        return view
    }()
    
    let reviewView: ChatSettingSubView = {
        let view = ChatSettingSubView()
        view.text.text = "리뷰 등록"
        view.image.image = UIImage(named: "write")
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
        self.addSubview(stackView)
        
        [reportView, cancelPromiseView, reviewView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        
    }
}
