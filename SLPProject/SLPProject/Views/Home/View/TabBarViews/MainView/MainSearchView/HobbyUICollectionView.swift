//
//  HobbyUICollectionView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/08.
//

import UIKit

class HobbyUICollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        register(HobbyUICollectionViewCell.self, forCellWithReuseIdentifier: HobbyUICollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
