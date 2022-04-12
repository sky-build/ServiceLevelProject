//
//  MainNearSeSACViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

class MainNearSeSACViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainNearView()
    
    var disposeBag = DisposeBag()
    
    let vc: CustomAlertViewController = {
        let vc = CustomAlertViewController()
        vc.viewState = .requestFriends
        return vc
    }()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.separatorStyle = .none
        
        viewModel.model.nearFriendsState.accept(Array(repeating: false, count: viewModel.model.nearFriends.value.count))
        
        viewModel.model.nearFriendsState
            .subscribe { [self] _ in
                mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        viewModel.model.nearFriends
            .subscribe { [self] _ in
                mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        // 커스텀뷰 설정
        setCustomAlertView()
    }
    
    // 커스텀뷰 설정
    private func setCustomAlertView() {
        vc.state
            .subscribe(onNext: { [self] state in
                if state {
                    // queue/hobbyrequest 요청
                    viewModel.queueAPI.hobbyRequest()
                }
            })
            .disposed(by: disposeBag)
    }
    
}

extension MainNearSeSACViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.model.nearFriends.value.count
        mainView.state = (count == 0) ? .none : .moreThenOne
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        cell.view.profileUserNameView.userNameLabel.text = viewModel.model.nearFriends.value[indexPath.row].nick
        cell.view.requestButtonState = .request
        // 태그 설정
        cell.view.profileUserNameView.stratchButton.tag = indexPath.row
        cell.view.requestButton.tag = indexPath.row
        
        // 컬렉션뷰 설정
        cell.view.profileTitleView.titleCollectionViews.setViewState(viewModel.model.nearFriends.value[indexPath.row].reputation)
        
        // 댓글 불러오기
        let comments = viewModel.model.nearFriends.value[indexPath.row].reviews
        if comments.count == 0 {
            cell.view.profileCommentView.commentState = .zero
        } else if comments.count == 1 {
            cell.view.profileCommentView.commentState = .one
            cell.view.profileCommentView.comment.text = comments[0]
        } else {
            cell.view.profileCommentView.commentState = .morethenTwo
            cell.view.profileCommentView.comment.text = comments[0]
        }
        
        if viewModel.model.nearFriendsState.value[indexPath.row] {
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
        var array = viewModel.model.nearFriendsState.value
        array[sender.tag].toggle()
        viewModel.model.nearFriendsState.accept(array)
    }
    
    @objc private func requestButtonClicked(_ sender: UIButton) {
        viewModel.model.selectedDataIndex = sender.tag
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
}
