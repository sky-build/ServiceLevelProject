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
        
        mainView.profileView.sesacTitleView.titleViews.delegate = self
        mainView.profileView.sesacTitleView.titleViews.dataSource = self
        mainView.profileView.sesacTitleView.titleViews.register(ProfileTitleViewCell.self, forCellWithReuseIdentifier: ProfileTitleViewCell.identifier)
        
//        mainView.profileView.profileFrame.rx.tapGesture()
//            .when(.recognized)
//            .subscribe { [weak self] _ in
//  
//                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
//                    let view = self?.mainView.profileView.profileFrame
//                    if view!.bounds.height == 58 {
//                        view!.snp.updateConstraints {
//                            $0.height.equalTo(100)
////                            $0.bottom.equalTo(self?.mainView.profileView.testView.snp.bottom)
//                        }
//                    } else {
//                        view!.snp.updateConstraints {
//                            $0.height.equalTo(58)
////                            $0.bottom.equalTo(self?.mainView.profileView.profileView.snp.bottom)
//                        }
//                    }
//                    view?.layoutIfNeeded()
//                    
//                }, completion: nil)
//            }
//            .disposed(by: disposeBag)

    }
    
}

extension InformationManagementViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileTitleViewCell.identifier, for: indexPath) as! ProfileTitleViewCell
        
        cell.state = indexPath.row % 2 == 0
        cell.label.text = "\(indexPath.row) 번째입니다."
        
        return cell
    }
    
    // 셀 크기 설정(전체화면)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 32)
    }
}
