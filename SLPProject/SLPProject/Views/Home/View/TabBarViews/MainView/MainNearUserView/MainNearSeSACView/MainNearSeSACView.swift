//
//  MainNearSeSACView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit
import SnapKit

class MainNearSeSACView: UIView, FetchViews {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainNearSeSACTableViewCell.self, forCellReuseIdentifier: MainNearSeSACTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

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
            $0.edges.equalTo(super.safeAreaLayoutGuide)
        }
    }
    
}
