//
//  MyInfoDeRegisterView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/04.
//

import UIKit
import SnapKit

class MyInfoDeRegisterView: UIView, FetchViews {
    
    let deRegisterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 탈퇴"
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
        [deRegisterTitleLabel].forEach {
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        deRegisterTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
