//
//  HobbyCollectionViewHeader.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/15.
//

import UIKit
import SnapKit

class HobbyCollectionViewHeader: UICollectionReusableView, FetchViews {
    
    static let identifier = "HobbyCollectionViewHeader"
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
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
        self.addSubview(title)
    }
    
    func makeConstraints() {
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
}
