//
//  CategoryView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/28.
//

import UIKit
import SnapKit

class ProfileTitleViewCell: UICollectionViewCell, FetchViews {
    
    static let identifier = "ProfileTitleViewCell"
    
    var state: Bool = false {
        didSet {
            if state {
                self.backgroundColor = .slpGreen
                self.label.textColor = .slpWhite
            } else {
                self.backgroundColor = .slpWhite
                self.label.textColor = .slpBlack
            }
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.slpGray2.cgColor
        self.layer.borderWidth = 1
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(label)
    }
    
    func makeConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
