//
//  MyInfoView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import SnapKit

class MyInfoView: UIView, FetchViews {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
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
        self.addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
