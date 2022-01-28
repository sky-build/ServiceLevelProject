//
//  UserInformationViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Toast

class MyInfoViewController: BaseViewController {
    
    let mainView = MyInfoView()
    
    let data = BehaviorRelay<[String]>(value: ["공지사항", "자주 묻는 질문", "1:1 채팅", "알림 설정", "이용 약관"])
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        data
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items) { [weak self] (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                
                var configuration = cell.defaultContentConfiguration()
                configuration.text = self?.data.value[row]
                
                cell.contentConfiguration = configuration
                
                return cell
            }
            .disposed(by: disposeBag)

        mainView.tableView
            .rx.itemSelected
            .subscribe { [weak self] indexPath in
//                self?.view.makeToast(self?.data.value[indexPath.row])
                self?.navigationController?.pushViewController(InformationManagementViewController(), animated: true)
            }
            .disposed(by: disposeBag)

    }
    
}
