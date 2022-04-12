//
//  ProfileCommentView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

enum Comment {
    case zero
    case one
    case morethenTwo
}

class ProfileCommentView: UIView, FetchViews {
    
    var commentState: Comment = .zero {
        didSet {
            switch commentState {
            case .zero:
                comment.textColor = .slpGray6
                comment.text = "첫 리뷰를 기다리는 중이에요!"
                commentButton.isHidden = true
            case .one:
                comment.textColor = .slpBlack
                commentButton.isHidden = true
            case .morethenTwo:
                comment.textColor = .slpBlack
                commentButton.isHidden = false
            }
        }
    }
    
    var comments: [String] = [] {
        didSet {
            if comments.count == 0 {
                commentState = .zero
            } else if comments.count == 1 {
                commentState = .one
            } else if comments.count > 1 {
                commentState = .morethenTwo
            }
            
            if comments.count >= 1 {
                fetchReview(comments[0])
            }
        }
    }
    
    let commentTitle: UILabel = {
        let label = UILabel()
        label.text = "새싹 리뷰"
        label.font = .Title6_R12
        return label
    }()
    
    let comment: UILabel = {
        let label = UILabel()
        label.text = "첫 리뷰를 기다리는 중이에요!"

        label.numberOfLines = 0
        label.font = .Body3_R14
        return label
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "more_arrow"), for: .normal)
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
        [commentTitle, comment, commentButton].forEach {
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
        
        commentButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(15)
            $0.centerY.equalTo(commentTitle)
        }
    }
    
    // 리뷰 반영
    private func fetchReview(_ commentContent: String) {
        comment.text = commentContent
    }
}
