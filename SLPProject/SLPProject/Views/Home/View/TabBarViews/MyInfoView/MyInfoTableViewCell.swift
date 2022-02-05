//
//  MyInfoTableViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/05.
//

import UIKit
import SnapKit

class MyInfoTableViewCell: UITableViewCell, FetchViews {
    
    static let identifier = "MyInfoTableViewCell"
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile_img")
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = .Title1_M16
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more_arrow"), for: .normal)
        return button
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
        [profileImageView, userName, moreButton].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        userName.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(13)
            $0.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(22.5)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(9)
            $0.height.equalTo(18)
        }
    }
    
}
