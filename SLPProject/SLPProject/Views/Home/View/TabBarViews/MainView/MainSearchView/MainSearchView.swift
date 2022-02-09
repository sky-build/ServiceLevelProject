//
//  MainSearchView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import SnapKit

class MainSearchView: UIView, FetchViews {
    
    let collectionView: HobbyUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        // 컬렉션뷰 크기 다이나믹하게 설정
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let view = HobbyUICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HobbyUICollectionViewCell.self, forCellWithReuseIdentifier: HobbyUICollectionViewCell.identifier)
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
        [collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(super.safeAreaLayoutGuide)
        }
    }
    
}
