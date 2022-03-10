//
//  ChatSettingView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/27.
//

import UIKit
import SnapKit

class ChatSettingView: UIView, FetchViews {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .slpWhite
        return view
    }()
    
    let reportView: ChatSettingSubView = {
        let view = ChatSettingSubView()
        view.text.text = "새싹 신고"
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
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [stackView, bottomView].forEach {
            self.addSubview($0)
        }
        
        [reportView, cancelPromiseView, reviewView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        self.snp.makeConstraints {
            $0.edges.equalTo(super.safeAreaLayoutGuide)
        }
        
        stackView.backgroundColor = .slpGreen
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
    }
}
