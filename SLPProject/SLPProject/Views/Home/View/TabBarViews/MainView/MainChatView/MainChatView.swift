//
//  MainChatView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit

class MainChatView: UIView, FetchViews {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainMyChatTableViewCell.self, forCellReuseIdentifier: MainMyChatTableViewCell.identifier)
        tableView.register(MainFriendChatTableViewCell.self, forCellReuseIdentifier: MainFriendChatTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let chatView = ChatTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [tableView, chatView].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(chatView.snp.top).inset(-16)
        }
        
        chatView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(30 + 32)
        }
    }
    
}
