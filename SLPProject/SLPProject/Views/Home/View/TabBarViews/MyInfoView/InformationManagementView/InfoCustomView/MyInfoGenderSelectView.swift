//
//  GenderSelectView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

class MyInfoGenderSelectView: UIView, FetchViews {
    
    var genderState: GenderType = .none {
        didSet {
            switch genderState {
            case .none:
                manButton.buttonState = false
                womanButton.buttonState = false
            case .man:
                manButton.buttonState = true
                womanButton.buttonState = false
            case .woman:
                manButton.buttonState = false
                womanButton.buttonState = true
            }
        }
    }
    
    let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = .Title4_R14
        return label
    }()
    
    let manButton: CusomButton = {
        let button = CusomButton()
        button.setTitle("남자", for: .normal)
        return button
    }()
    
    let womanButton: CusomButton = {
        let button = CusomButton()
        button.setTitle("여자", for: .normal)
        return button
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
        [genderTitleLabel, manButton, womanButton].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        genderTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        womanButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(56)
            $0.height.equalTo(48)
        }
        
        manButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(womanButton.snp.leading).inset(-10)
            $0.width.equalTo(56)
            $0.height.equalTo(48)
        }
    }
}
