//
//  ProfileTitleContentView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/03/01.
//

import UIKit
import SnapKit

class ProfileTitleContentView: UIView, FetchViews {
    
    let view1: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "좋은 매너"
        return view
    }()
    let view2: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "정확한 시간 약속"
        return view
    }()
    let view3: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "빠른 응답"
        return view
    }()
    let view4: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "친절한 성격"
        return view
    }()
    let view5: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "능숙한 취미 실력"
        return view
    }()
    let view6: ProfileTitleContent = {
        let view = ProfileTitleContent()
        view.title.text = "유익한 시간"
        return view
    }()
    var views: [ProfileTitleContent] = []
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    let stackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
        
        [view1, view2, view3, view4, view5, view6].forEach {
            $0.state = false
            views.append($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(stackView)
        
        [stackView1, stackView2, stackView3].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [view1, view2].forEach {
            stackView1.addArrangedSubview($0)
        }
        
        [view3, view4].forEach {
            stackView2.addArrangedSubview($0)
        }
        
        [view5, view6].forEach {
            stackView3.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        [stackView1, stackView2, stackView3].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(32)
            }
        }
    }
    
    func setViewState(_ reputation: [Int]) {
        for i in 0..<6 {
            views[i].state = reputation[i] > 0 ? true : false
        }
    }
    
}
