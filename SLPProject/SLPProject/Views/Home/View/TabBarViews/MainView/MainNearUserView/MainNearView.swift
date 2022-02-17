//
//  MainNearView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit
import SnapKit

enum TableViewExist {
    case moreThenOne
    case none
}

class MainNearView: UIView, FetchViews {
    
    let emptyView = MainEmptyView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension

        return tableView
    }()
    
    var state: TableViewExist = .none {
        didSet {
            switch state {
            case .none:
                emptyView.isHidden = false
                tableView.isHidden = true
            case .moreThenOne:
                emptyView.isHidden = true
                tableView.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [emptyView, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        emptyView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(super.safeAreaLayoutGuide)
            $0.bottom.equalTo(super.safeAreaLayoutGuide).inset(80)
        }
    }
    
}
