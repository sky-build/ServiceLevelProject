//
//  DateView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class DateView: UIView, FetchViews {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textColor = .slpGray7
        return label
    }()
    
    let dateTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2_R16
        label.textColor = .slpBlack
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slpGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 뷰 너비를 고정해줌
        self.snp.makeConstraints {
            $0.width.equalTo(99)
        }
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(dateLabel)
        self.addSubview(dateTypeLabel)
        self.addSubview(bottomLine)
    }
    
    func makeConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(12)
        }
        
        dateTypeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.trailing.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(19)
            $0.height.equalTo(2)
        }
    }
    
    // 데이터타입(년, 월, 일) 설정
    func setDateType(_ type: DateType) {
        dateTypeLabel.text = type.rawValue
    }
    
    // 라벨 설정(텍스트색상도 변경해줌)
    func setLabel(_ text: String) {
        dateLabel.text = text
    }
    
    // 라벨 텍스트색상 변경
    func setLabelColor(_ state: Bool) {
        if state {
            dateLabel.textColor = .slpBlack
        } else {
            dateLabel.textColor = .slpGray7
        }
    }
}
