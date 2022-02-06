//
//  MainFilterButtons.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit

class MainFilterButtons: UIStackView, FetchViews {
    
    var selectButton: MainViewFilterState = .all {
        didSet {
            switch selectButton {
            case .all:
                allButton.buttonState = true
                manButton.buttonState = false
                womanButton.buttonState = false
            case .man:
                allButton.buttonState = false
                manButton.buttonState = true
                womanButton.buttonState = false
            case .woman:
                allButton.buttonState = false
                manButton.buttonState = false
                womanButton.buttonState = true
            }
        }
    }
    
    let allButton: CustomFilterButton = {
        let button = CustomFilterButton()
        button.buttonState = false
        button.setTitle("전체", for: .normal)
        return button
    }()
    
    let manButton: CustomFilterButton = {
        let button = CustomFilterButton()
        button.buttonState = false
        button.setTitle("남자", for: .normal)
        return button
    }()
    
    let womanButton: CustomFilterButton = {
        let button = CustomFilterButton()
        button.buttonState = false
        button.setTitle("여자", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [allButton, manButton, womanButton].forEach {
            self.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        self.layer.cornerRadius = 8
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.clipsToBounds = true
    }
    
}
