//
//  MainEmptyView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/17.
//

import UIKit
import SnapKit

class MainEmptyView: UIView, FetchViews {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty_image")
        return view
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .Display1_R20
        label.text = "아직 받은 요청이 없어요ㅠ"
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
        label.textColor = .slpGray7
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
        [imageView, mainLabel, subLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
}
