//
//  InformationManagementView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import SnapKit

class InformationManagerView: UIView, FetchViews {
    
    let profileView = ProfileCustomView()
    
    // 성별 선택 뷰
    let selectGenderView = UIView()
    let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = .Title4_R14
        return label
    }()
    let manButton: CusomButton = {
        let button = CusomButton()
        button.setTitle("남자", for: .normal)
        button.buttonState = false
        return button
    }()
    let womanButton: CusomButton = {
        let button = CusomButton()
        button.setTitle("여자", for: .normal)
        button.buttonState = false
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
        self.addSubview(profileView)
        
        [genderTitleLabel, manButton, womanButton].forEach {
            selectGenderView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        profileView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
}
