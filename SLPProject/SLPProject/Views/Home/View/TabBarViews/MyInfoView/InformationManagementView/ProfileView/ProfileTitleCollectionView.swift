//
//  ProfileTitleCollectionView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/28.
//

import UIKit

class ProfileTitleCollectionView: UICollectionView {
    
    var index = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
