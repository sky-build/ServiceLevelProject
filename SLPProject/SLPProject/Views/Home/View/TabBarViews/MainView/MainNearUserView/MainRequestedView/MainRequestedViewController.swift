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
//        cell.index = indexPath.row
        cell.view.profileTitleView.titleCollectionViews.delegate = self
        cell.view.profileTitleView.titleCollectionViews.dataSource = self
        
        if viewModel.model.requestNearFriendsState.value[indexPath.row] {
            cell.view.profileUserNameView.stratchButton.setImage(UIImage(named: "button.up"), for: .normal)
            cell.view.profileTitleView.isHidden = false
            cell.view.profileCommentView.isHidden = false
        } else {
            cell.view.profileUserNameView.stratchButton.setImage(UIImage(named: "button.down"), for: .normal)
            cell.view.profileTitleView.isHidden = true
            cell.view.profileCommentView.isHidden = true
        }
        
        cell.view.requestButton.addTarget(self, action: #selector(requestButtonClicked(_:)), for: .touchUpInside)
        
        cell.view.profileUserNameView.stratchButton.addTarget(self, action: #selector(stratchButtonClicked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func stratchButtonClicked(_ sender: UIButton) {
        var array = viewModel.model.requestNearFriendsState.value
        array[sender.tag].toggle()
        viewModel.model.requestNearFriendsState.accept(array)
    }
    
    @objc private func requestButtonClicked(_ sender: UIButton) {
        print("\(sender.tag) 번째 버튼 클릭")
    }
}

extension MainRequestedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileTitleViewCell.identifier, for: indexPath) as! ProfileTitleViewCell
        
        let row = viewModel.model.requestNearFriends.value[cell.index].reputation
        
        cell.state = row[indexPath.row] == 1
        let cellTexts = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
        cell.label.text = cellTexts[indexPath.row]
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 64) / 2 * 0.97, height: 32)
    }
}
