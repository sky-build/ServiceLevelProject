//
//  OnboardingView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/22.
//

import UIKit
import SnapKit

class OnboardingView: UIView, FetchViews {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let pager: UIPageControl = {
        let pager = UIPageControl()
        pager.numberOfPages = 3
        pager.pageIndicatorTintColor = .slpGray3
        pager.currentPageIndicatorTintColor = .slpBlack
        return pager
    }()
    
    let startButton: CustomNextButton = {
        let button = CustomNextButton()
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .Body3_R14
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 컬렉션뷰 설정
        setCollectionView()
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 컬렉션뷰 설정
    func setCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }
    
    func addViews() {
        self.addSubview(collectionView)
        self.addSubview(startButton)
        self.addSubview(pager)
    }
    
    func makeConstraints() {
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(pager.snp.top).inset(-56)
        }
        
        pager.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top).inset(-42)
            $0.centerX.equalToSuperview()
        }
    }
}
