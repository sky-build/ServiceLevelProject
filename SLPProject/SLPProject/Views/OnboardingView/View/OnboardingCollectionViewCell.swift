//
//  OnboardingCollectionViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/22.
//

import UIKit
import SnapKit

class OnboardingCollectionViewCell: UICollectionViewCell, FetchViews {
    
    static let identifier = "OnboardingCollectionViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Onboarding_R24
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
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
        self.addSubview(titleLabel)
        self.addSubview(imageView)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(72)
            $0.leading.trailing.equalToSuperview().inset(85)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(super.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.0)
        }
    }
}
