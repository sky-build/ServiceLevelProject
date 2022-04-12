//
//  MainRequestedViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit
import RxSwift
import RxCocoa

class MainRequestedViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainNearView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.separatorStyle = .none
        
        viewModel.model.requestNearFriendsState
            .subscribe { [self] _ in
                mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        viewModel.model.requestNearFriends
            .subscribe { [self] _ in
                mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
}

extension MainRequestedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.model.requestNearFriends .value.count
        mainView.state = (count == 0) ? .none : .moreThenOne
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        cell.view.profileUserNameView.userNameLabel.text = viewModel.model.requestNearFriends.value[indexPath.row].nick
        cell.view.requestButtonState = .ok
        // 태그 설정
        cell.view.profileUserNameView.stratchButton.tag = indexPath.row
        cell.view.requestButton.tag = indexPath.row
        
        // 컬렉션뷰 설정

        
        if viewModel.model.requestNearFriendsState.value[indexPath.row] {
            cell.view.profileUserNameView.stratchButton.setImage(UIImage(named: "button.up"), for: .normal)
            cell.view.profileTitleView.isHidden = false
            cell.view.profileCommentView.isHidden = false
        } else {
            cell.view.profileUserNameView.stratchButton.setImage(UIImage(named: "button.down"), for: .normal)
            cell.view.profileTitleView.isHidden = true
            cell.view.profileCommentView.isHidden = true
        }
        
        cell.view.profileUserNameView.stratchButton.addTarget(self, action: #selector(stratchButtonClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func stratchButtonClicked(_ sender: UIButton) {
        var array = viewModel.model.requestNearFriendsState.value
        array[sender.tag].toggle()
        viewModel.model.requestNearFriendsState.accept(array)
    }
}
