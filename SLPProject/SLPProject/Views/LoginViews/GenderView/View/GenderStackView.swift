//
//  GenderStackView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class GenderStackView: UIView, FetchViews {
    
    let manView: GenderView = {
        let label = GenderView()
        label.genderLabel.text = "남자"
        label.genderImage.image = UIImage(named: "man")
        return label
    }()
    
    let womanView: GenderView = {
        let label = GenderView()
        label.genderLabel.text = "여자"
        label.genderImage.image = UIImage(named: "woman")
        return label
    }()
    
    let stackGenderView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackGenderView.axis = .horizontal
        stackGenderView.spacing = 8
        stackGenderView.distribution = .fillEqually
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        stackGenderView.addArrangedSubview(manView)
        stackGenderView.addArrangedSubview(womanView)
        self.addSubview(stackGenderView)
    }
    
    func makeConstraints() {
        stackGenderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
