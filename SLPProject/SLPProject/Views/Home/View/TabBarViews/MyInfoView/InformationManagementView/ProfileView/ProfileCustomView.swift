//
//  ProfileCustomView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import SnapKit

class ProfileCustomView: UIView, FetchViews {
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sesac_background_1")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sesac_face_1")
        return image
    }()
    
    let profileFrame: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill    // 가운데 채움
        view.backgroundColor = .slpWhite
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.slpGray2.cgColor
        return view
    }()
    
    let profileUserNameView = ProfileUserNameView()
    
    let profileTitleView: ProfileTitleView = {
        let view = ProfileTitleView()
        view.isHidden = true
        return view
    }()
    
    let profileCommentView: ProfileCommentView = {
        let view = ProfileCommentView()
        view.isHidden = true
        view.commentState = .zero
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileUserNameView.stratchButton.addTarget(self, action: #selector(stratchButtonClicked(_:)), for: .touchUpInside)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(backgroundImageView)
        self.addSubview(profileImage)
        self.addSubview(profileFrame)
        [profileUserNameView, profileTitleView, profileCommentView].forEach {
            profileFrame.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(194)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImageView).offset(-10)
            $0.top.equalTo(backgroundImageView.snp.top).inset(19)
            $0.width.height.equalTo(184)
        }
        
        profileFrame.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom)
            $0.leading.trailing.equalTo(backgroundImageView)
            $0.bottom.equalToSuperview()
        }
        
        profileUserNameView.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        profileTitleView.snp.makeConstraints {
            $0.height.equalTo(165)
        }
        
        profileCommentView.snp.makeConstraints {
            $0.bottom.equalTo(profileFrame.snp.bottom)
        }
    }
    
    @objc func stratchButtonClicked(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "button.down") {
            sender.setImage(UIImage(named: "button.up"), for: .normal)
            profileTitleView.isHidden = false
            profileCommentView.isHidden = false
        } else {
            sender.setImage(UIImage(named: "button.down"), for: .normal)
            profileTitleView.isHidden = true
            profileCommentView.isHidden = true
        }
    }
}
