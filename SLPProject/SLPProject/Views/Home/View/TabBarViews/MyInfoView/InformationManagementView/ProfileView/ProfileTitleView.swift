//
//  SeSACTitle.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/28.
//

import UIKit
import SnapKit

class ProfileTitleView: UIView, FetchViews {
    
//    let cellTexts = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
//    var cellState = [0, 0, 0, 0, 0, 0] {
//        didSet {
//            titleCollectionViews.reloadData()
//        }
//    }
    
    let titleText: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = .Title6_R12
        return label
    }()
    
//    let titleCollectionViews: ProfileTitleCollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        layout.minimumLineSpacing = 8
//        layout.scrollDirection = .vertical
//
//        let collectionView = ProfileTitleCollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.isScrollEnabled = false
//        collectionView.register(ProfileTitleViewCell.self, forCellWithReuseIdentifier: ProfileTitleViewCell.identifier)
//        return collectionView
//    }()
    
    let titleCollectionViews = ProfileTitleContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(titleText)
        self.addSubview(titleCollectionViews)
    }
    
    func makeConstraints() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(40-24)
        }
        
        titleCollectionViews.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}
