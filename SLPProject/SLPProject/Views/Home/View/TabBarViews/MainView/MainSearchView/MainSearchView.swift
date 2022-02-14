//
//  MainSearchView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import SnapKit

class MainSearchView: UIView, FetchViews {
    
    let nowSurroundLabel: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.text = "지금 주변에는"
        return label
    }()
    
    let recommandCollectionView: HobbyUICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        // 컬렉션뷰 크기 다이나믹하게 설정
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let view = HobbyUICollectionView(frame: .zero, collectionViewLayout: layout)
        view.state = .red

        return view
    }()
    
    let nearHobbyCollectionView: HobbyUICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        // 컬렉션뷰 크기 다이나믹하게 설정
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let view = HobbyUICollectionView(frame: .zero, collectionViewLayout: layout)
        view.state = .black
        
        return view
    }()
    
    let myFavoriteLabel: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.text = "내가 하고 싶은"
        return label
    }()
    
    let myFavoriteCollectionView: HobbyUICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        // 컬렉션뷰 크기 다이나믹하게 설정
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let view = HobbyUICollectionView(frame: .zero, collectionViewLayout: layout)
        view.state = .green
        
        return view
    }()
    
    let bottomButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("새싹 찾기", for: .normal)
        return button
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [scrollView, bottomButton].forEach {
            self.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [nowSurroundLabel, recommandCollectionView, nearHobbyCollectionView, myFavoriteLabel, myFavoriteCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomButton)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        nowSurroundLabel.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).inset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        recommandCollectionView.snp.makeConstraints {
            $0.top.equalTo(nowSurroundLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.height.greaterThanOrEqualTo(50)
//            $0.height.equalTo(50)
        }
        
        nearHobbyCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommandCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.height.greaterThanOrEqualTo(100)
//            $0.height.equalTo(200)
        }
        
        myFavoriteLabel.snp.makeConstraints {
            $0.top.equalTo(nearHobbyCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        myFavoriteCollectionView.snp.makeConstraints {
            $0.top.equalTo(myFavoriteLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.greaterThanOrEqualTo(200)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        bottomButton.snp.makeConstraints {
            $0.bottom.equalTo(super.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) ->  [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0
    
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
