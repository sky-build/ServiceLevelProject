//
//  MyInfoFavoriteHabitView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit

class MyInfoFavoriteHabitView: UIView, FetchViews {
    
    let habitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 취미"
        label.font = .Title4_R14
        return label
    }()
    
    let habitTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.textField.placeholder = "취미를 입력해 주세요"
        return textField
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
        [habitTitleLabel, habitTextField].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        habitTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        habitTextField.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(164)
            $0.centerY.equalToSuperview()
        }
    }
    
}
