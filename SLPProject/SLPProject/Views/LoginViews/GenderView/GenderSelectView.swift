//
//  GenderView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit

class GenderSelectView: UIView, FetchViews {
    
    let explainLabel: ExplainLabel = {
        let label = ExplainLabel()
        label.text = "성별을 선택해 주세요"
        label.textAlignment = .center
        return label
    }()
    
    let subExplainLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        label.textAlignment = .center
        label.textColor = .slpGray7
        return label
    }()
    
    let manView: GenderView = {
        let label = GenderView()
        label.genderLabel.text = "남자"
        label.genderImage.image = UIImage(named: "man")
        return label
    }()
    
    let genderView: GenderStackView = {
        let view = GenderStackView()
        return view
    }()
    
    let nextButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .Body3_R14
        button.backgroundColor = .slpGray6
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
        self.addSubview(explainLabel)
        self.addSubview(subExplainLabel)
        self.addSubview(genderView)
        self.addSubview(nextButton)
    }
    
    func makeConstraints() {
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.equalToSuperview().inset(57)
        }
        
        subExplainLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        genderView.snp.makeConstraints {
            $0.top.equalTo(subExplainLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(120)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(genderView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    
}
