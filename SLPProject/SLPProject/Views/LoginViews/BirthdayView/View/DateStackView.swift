//
//  DateStackView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import SnapKit

class DateStackView: UIView, FetchViews {
    
    let yearView: DateView = {
        let view = DateView()
        view.setDateType(.year)
        return view
    }()
    
    let montyView: DateView = {
        let view = DateView()
        view.setDateType(.month)
        return view
    }()
    
    let dayView: DateView = {
        let view = DateView()
        view.setDateType(.day)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [yearView, montyView, dayView])
        
        view.axis = .horizontal
        view.distribution = .equalSpacing
        
        return view
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
        self.addSubview(stackView)
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 텍스트 색상 설정
    func setLabelColor(_ state: Bool) {
        yearView.setLabelColor(state)
        montyView.setLabelColor(state)
        dayView.setLabelColor(state)
    }
}
