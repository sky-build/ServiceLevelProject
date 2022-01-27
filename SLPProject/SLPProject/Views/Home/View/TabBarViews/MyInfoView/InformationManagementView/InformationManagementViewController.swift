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
        
//        mainView.profileView.profileFrame.rx.tapGesture()
//            .when(.recognized)
//            .subscribe { [weak self] _ in
//  
//                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
//                    let view = self?.mainView.profileView.profileFrame
//                    if view!.bounds.height == 58 {
//                        view!.snp.updateConstraints {
//                            $0.height.equalTo(100)
//                        }
//                    } else {
//                        view!.snp.updateConstraints {
//                            $0.height.equalTo(58)
//                        }
//                    }
//                    view?.layoutIfNeeded()
//                    
//                }, completion: nil)
//            }
//            .disposed(by: disposeBag)

    }
    
}
