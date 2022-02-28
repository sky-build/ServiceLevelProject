//
//  MainTableViewCell.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell, FetchViews {
    
    static let identifier = "MainTableViewCell"
    
    let view = ProfileCustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addViews() {
        contentView.addSubview(view)
    }
    
    func makeConstraints() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
