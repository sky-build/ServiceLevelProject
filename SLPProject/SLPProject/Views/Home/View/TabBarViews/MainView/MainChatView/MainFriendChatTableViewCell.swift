//
//  MainFriendChatTableViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit

class MainFriendChatTableViewCell: UITableViewCell, FetchViews {
    
    static let identifier = "MainFriendChatTableViewCell"
    
    let chatView: ChatView = {
        let view = ChatView()
        view.type = .friends
        return view
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.textColor = .slpGray6
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [chatView, date].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        chatView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(95)
        }
        
        date.snp.makeConstraints {
            $0.leading.equalTo(chatView.snp.trailing).offset(8)
            $0.bottom.equalTo(chatView.snp.bottom)
        }
    }
    
}
