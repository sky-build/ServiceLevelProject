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
    
    let images = [UIImage(named: "notice"), UIImage(named: "faq"), UIImage(named: "qna"), UIImage(named: "setting_alarm"), UIImage(named: "permit")]
    let data = BehaviorRelay<[String]>(value: ["공지사항", "자주 묻는 질문", "1:1 채팅", "알림 설정", "이용 약관"])
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.rowHeight = 74
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // seperator 양쪽 Inset 15씩 줌(top, bottom은 값 상관없음)
        mainView.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        data
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items) { [weak self] (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                
                var configuration = cell.defaultContentConfiguration()
                configuration.text = self?.data.value[row]
                configuration.image = self?.images[row]
                
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
