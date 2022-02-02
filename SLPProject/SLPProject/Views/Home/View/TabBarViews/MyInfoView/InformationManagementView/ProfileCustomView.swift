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
    
    let profileFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .slpWhite
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.slpGray2.cgColor
        return view
    }()
    
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
    
    let sesacTitleView = SeSACTitleView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stratchButton.addTarget(self, action: #selector(stratchButtonClicked(_:)), for: .touchUpInside)
        
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
        profileFrame.addSubview(userNameLabel)
        profileFrame.addSubview(stratchButton)
        profileFrame.addSubview(sesacTitleView)
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
            $0.height.equalTo(58)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.leading.equalTo(profileFrame).inset(16)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        stratchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.width.height.equalTo(12)
            $0.centerY.equalTo(userNameLabel)
        }
        
        sesacTitleView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    @objc func stratchButtonClicked(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "button.down") {
            sender.setImage(UIImage(named: "button.up"), for: .normal)
            profileFrame.snp.updateConstraints {
//                $0.bottom.equalTo(testView.snp.bottom)
                $0.height.equalTo(400)
            }
        } else {
            sender.setImage(UIImage(named: "button.down"), for: .normal)
            profileFrame.snp.updateConstraints {
//                $0.bottom.equalTo(profileView.snp.bottom)
                $0.height.equalTo(58)
            }
        }
    }
}
