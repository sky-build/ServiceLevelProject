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
        image.image = UIImage(named: "background")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "face_01")
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
    
    let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .slpBlack
        return view
    }()
    
    // 크기 늘였다 줄였다하는 버튼
    let stratchButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "button.down"), for: .normal)
        return button
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.backgroundColor = .slpGreen
        return view
    }()
    
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
        profileFrame.addSubview(profileView)
        profileFrame.addSubview(stratchButton)
        // 테스트뷰
        self.addSubview(testView)
    }
    
    func makeConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(194)
        }
        
        profileImage.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImageView)
            $0.top.equalTo(backgroundImageView.snp.top).offset(19)
            $0.width.height.equalTo(184)
        }
        
        profileFrame.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom)
            $0.leading.trailing.equalTo(backgroundImageView)
//            $0.height.equalTo(58)
            $0.bottom.equalTo(profileView)
        }
        
        profileView.snp.makeConstraints {
            $0.top.leading.equalTo(profileFrame).inset(20)
            $0.width.height.equalTo(20)
        }
        
        stratchButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(12)
            $0.height.equalTo(6)
        }
        
        // 테스트뷰
        testView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
    
    @objc func stratchButtonClicked(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "button.down") {
            sender.setImage(UIImage(named: "button.up"), for: .normal)
            profileFrame.snp.updateConstraints {
                $0.bottom.equalTo(testView.snp.bottom)
            }
        } else {
            sender.setImage(UIImage(named: "button.down"), for: .normal)
            profileFrame.snp.updateConstraints {
                $0.bottom.equalTo(profileView.snp.bottom)
            }
        }
    }
}
