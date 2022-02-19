//
//  ChatView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit

enum ChatType {
    case my
    case friends
}

class ChatView: UIView, FetchViews {
    
    let text: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var type: ChatType = .my {
        didSet {
            switch type {
            case .my:
                self.layer.borderColor = nil
                self.layer.borderWidth = 0
                self.backgroundColor = .slpWhiteGreen
            case .friends:
                self.layer.borderColor = UIColor.slpGray4.cgColor
                self.layer.borderWidth = 1
                self.backgroundColor = .slpWhite
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
        
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(text)
    }
    
    func makeConstraints() {
        text.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
