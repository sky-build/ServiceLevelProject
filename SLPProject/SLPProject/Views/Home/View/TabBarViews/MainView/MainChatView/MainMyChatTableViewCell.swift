//
//  MainMyChatTableViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit

enum ReadState {
    case read
    case unread
}

class MainMyChatTableViewCell: UITableViewCell, FetchViews {
    
    static let identifier = "MainMyChatTableViewCell"
    
    var readState: ReadState = .read {
        didSet {
            switch readState {
            case .read:
                self.readStateLabel.isHidden = true
            case .unread:
                self.readStateLabel.isHidden = false
            }
        }
    }
    
    let chatView: ChatView = {
        let view = ChatView()
        view.type = .my
        return view
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.textColor = .slpGray6
        return label
    }()
    
    let readStateLabel: UILabel = {
        let label = UILabel()
        label.font = .caption_R10
        label.text = "안읽음"
        label.textColor = .slpGreen
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
        [chatView, date, readStateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        chatView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(95)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        date.snp.makeConstraints {
            $0.trailing.equalTo(chatView.snp.leading).inset(-8)
            $0.bottom.equalTo(chatView.snp.bottom)
        }
        
        readStateLabel.snp.makeConstraints {
            $0.bottom.equalTo(date.snp.top).inset(-2)
            $0.centerX.equalTo(date)
        }
    }
    
}
