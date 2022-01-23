//
//  GenderView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class GenderView: UIView, FetchViews {
    
    let genderImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2_R16
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.slpBorderColor.cgColor
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(genderImage)
        self.addSubview(genderLabel)
    }
    
    func makeConstraints() {
        genderImage.snp.makeConstraints {
            $0.bottom.equalTo(genderLabel.snp.top).inset(-2)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }
        
        genderLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
}
