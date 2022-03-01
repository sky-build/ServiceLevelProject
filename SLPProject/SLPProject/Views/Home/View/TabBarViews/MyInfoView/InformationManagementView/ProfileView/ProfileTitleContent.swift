//
//  ProfileTitleContent.swift
//  SLPProject
//
//  Created by 노건호 on 2022/03/01.
//

import UIKit
import SnapKit

class ProfileTitleContent: UIView, FetchViews {
    
    var state: Bool = false {
        didSet {
            if state {
                title.textColor = .slpWhite
                backgroundColor = .slpGreen
                layer.borderColor = nil
                layer.borderWidth = 0
            } else {
                title.textColor = .slpBlack
                backgroundColor = .white
                layer.borderColor = UIColor.slpGray4.cgColor
                layer.borderWidth = 1
            }
        }
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
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
        self.layer.cornerRadius = 8
        
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
