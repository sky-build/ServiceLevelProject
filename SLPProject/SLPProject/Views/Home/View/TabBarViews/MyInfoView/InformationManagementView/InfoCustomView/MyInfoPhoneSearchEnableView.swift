//
//  MyInfoPhoneSearchEnableView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

class MyInfoPhoneSearchEnableView: UIView, FetchViews {
    
    let phoneSearchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = .Title4_R14
        return label
    }()
    
    let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = .slpGreen
        return toggleSwitch
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
        [phoneSearchTitleLabel, toggleSwitch].forEach {
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        phoneSearchTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
