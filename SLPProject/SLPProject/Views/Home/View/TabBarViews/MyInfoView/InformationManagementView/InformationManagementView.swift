//
//  InformationManagementView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import SnapKit

class InformationManagerView: UIView, FetchViews {
    
    let profileView = ProfileCustomView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(profileView)
    }
    
    func makeConstraints() {
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
