//
//  BirthdayView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class BirthdayView: UIView, FetchViews {
    
    // 프로퍼티 옵저버로 색상 변경
    var state = false {
        didSet {
            if state {
                // 텍스트 색상 검은색으로 바꿔줌
                dateLabel.setLabelColor(state)
                // 버튼색상 변경
                setNextButtonColor(state)
            }
        }
    }
    
    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "생년월일을 알려주세요"
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel = DateStackView()
    
    let nextButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .Body3_R14
        button.backgroundColor = .slpGray6
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        // 날짜만 선택
        picker.datePickerMode = .date
        // 오늘 이후에는 태어날 수 없기 때문에 오늘을 최대날짜로 설정
        picker.maximumDate = Date()
        return picker
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
        self.addSubview(explainLabel)
        self.addSubview(dateLabel)
        self.addSubview(nextButton)
        self.addSubview(datePicker)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(74)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(80)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(72)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(216)
        }
    }
    
    func setNextButtonColor(_ state: Bool) {
        if state {
            nextButton.backgroundColor = .slpGreen
        } else {
            nextButton.backgroundColor = .slpGray6
        }
    }
}
