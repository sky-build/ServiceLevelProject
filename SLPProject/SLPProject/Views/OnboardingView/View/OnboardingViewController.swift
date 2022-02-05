//
//  OnboardingViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/22.
//

import UIKit
import SnapKit
import RxSwift

class OnboardingViewController: BaseViewController {
    
    let viewModel = OnboardingViewModel()
    
    let mainView = OnboardingView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰 설정
        setCollectionView()
        
        // 시작하기 버튼 클릭했을 때
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked(_:)), for: .touchUpInside)
        
        // 페이저 설정
        mainView.pager.addTarget(self, action: #selector(pagerChanged(_:)), for: .valueChanged)
    }
    
    // 컬렉션뷰 설정
    func setCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    // 시작하기 버튼 클릭했을 떄
    @objc func startButtonClicked(_ sender: UIButton) {
        changeRootView(UINavigationController(rootViewController: PhoneNumberAuthViewController()))
    }
    
    // 페이지 변경되었을 때 설정
    @objc private func pagerChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        // 컬렉션뷰 위치를 선택한 위치로 이동
        mainView.collectionView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.width, y: 0), animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.attributedTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.titleLabel.attributedText = viewModel.attributedTitles[indexPath.row]
        cell.imageView.image = UIImage(named: "Onboarding\(indexPath.row + 1)")
        
        return cell
    }
    
    // 셀 크기 설정(전체화면)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    // 새 화면이 보일 때 페이저 수정
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 현재 페이지를 pager로 이동
        mainView.pager.currentPage = indexPath.row
    }
}
