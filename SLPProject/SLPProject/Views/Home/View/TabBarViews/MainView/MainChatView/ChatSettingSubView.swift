//
//  ChatSettingSubView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/27.
//

import UIKit
import SnapKit

class ChatSettingSubView: UIView, FetchViews {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.axis = .vertical
        return stackView
    }()
    
    let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    let text: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
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
        self.addSubview(stackView)
        
        [image, text].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        self.snp.makeConstraints {
            $0.center.equalTo(super.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
