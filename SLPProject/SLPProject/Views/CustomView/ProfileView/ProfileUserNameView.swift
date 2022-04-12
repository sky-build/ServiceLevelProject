//
//  ProfileTitleView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

class ProfileUserNameView: UIView, FetchViews {
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "김새싹"
        label.font = .Title1_M16
        return label
    }()
    
    // 크기 늘였다 줄였다하는 버튼
    let stratchButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "button.down"), for: .normal)
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
        [userNameLabel, stratchButton].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        userNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        stratchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(stratchButton.snp.height).multipliedBy(1.0)
            $0.centerY.equalToSuperview()
        }
    }
    
}
