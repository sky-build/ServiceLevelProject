//
//  InformationManagementViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import RxSwift
import RxGesture

class InformationManagementViewController: BaseViewController {
    
    let mainView = InformationManagerView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰 기본 설정
        setCollectionView()
    }
    
    // 컬렉션뷰 기본 설정
    private func setCollectionView() {
        mainView.profileView.profileTitleView.titleCollectionViews.delegate = self
        mainView.profileView.profileTitleView.titleCollectionViews.dataSource = self
        mainView.profileView.profileTitleView.titleCollectionViews.register(ProfileTitleViewCell.self, forCellWithReuseIdentifier: ProfileTitleViewCell.identifier)
    }
    
}

extension InformationManagementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.profileView.profileTitleView.cellTexts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileTitleViewCell.identifier, for: indexPath) as! ProfileTitleViewCell
        
        let row = indexPath.row
        cell.state = row == 0 || row == 3 || row == 4 || row == 5
        cell.label.text = mainView.profileView.profileTitleView.cellTexts[row]

        return cell
    }

    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 64) / 2 * 0.97, height: 32)
    }
}
