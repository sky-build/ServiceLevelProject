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
    
    // 컬렉션뷰 기본 설정
    private func setCollectionView() {
        mainView.profileView.sesacTitleView.titleCollectionViews.delegate = self
        mainView.profileView.sesacTitleView.titleCollectionViews.dataSource = self
        mainView.profileView.sesacTitleView.titleCollectionViews.register(ProfileTitleViewCell.self, forCellWithReuseIdentifier: ProfileTitleViewCell.identifier)
    }
    
}

extension InformationManagementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.profileView.sesacTitleView.cellTexts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileTitleViewCell.identifier, for: indexPath) as! ProfileTitleViewCell
        
        let row = indexPath.row
        cell.state = row == 0 || row == 3 || row == 4 || row == 5
        cell.label.text = mainView.profileView.sesacTitleView.cellTexts[row]

        return cell
    }

    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 64) / 2 * 0.97, height: 32)
    }
}
