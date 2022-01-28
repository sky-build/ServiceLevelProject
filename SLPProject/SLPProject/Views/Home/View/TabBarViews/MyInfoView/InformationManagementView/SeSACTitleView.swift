//
//  SeSACTitle.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/28.
//

import UIKit
import SnapKit

class SeSACTitleView: UIView, FetchViews {
    
    let titleViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
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
        self.addSubview(titleViews)
    }
    
    func makeConstraints() {
        titleViews.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
