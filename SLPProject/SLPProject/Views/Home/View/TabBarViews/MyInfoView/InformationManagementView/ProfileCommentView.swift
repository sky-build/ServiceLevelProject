//
//  ProfileCommentView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

class ProfileCommentView: UIView, FetchViews {
    
    let commentTitle: UILabel = {
        let label = UILabel()
        label.text = "새싹 리뷰"
        label.font = .Title6_R12
        return label
    }()
    
    let comment: UILabel = {
        let label = UILabel()
        label.text = "첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!첫 리뷰를 기다리는 중이에요!"
        
        label.numberOfLines = 0
        label.font = .Body3_R14
        return label
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
        [commentTitle, comment].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        commentTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        comment.snp.makeConstraints {
            $0.top.equalTo(commentTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
