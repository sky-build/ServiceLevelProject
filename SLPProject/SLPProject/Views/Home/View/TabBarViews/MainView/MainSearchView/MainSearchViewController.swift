//
//  MainSearchViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class MainSearchViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainSearchView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collectionView 설정
        setCollectionView()
        
        // searchBar 설정
        setSearchBar()
    }
    
    // collectionView 설정
    private func setCollectionView() {
        mainView.recommandCollectionView.delegate = self
        mainView.recommandCollectionView.dataSource = self
        
        mainView.nearHobbyCollectionView.delegate = self
        mainView.nearHobbyCollectionView.dataSource = self
        
        mainView.myFavoriteCollectionView.delegate = self
        mainView.myFavoriteCollectionView.dataSource = self
        
        viewModel.model.myHobby
            .subscribe { [self] value in
                mainView.myFavoriteCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    // searchBar 설정
    private func setSearchBar() {
        navigationController?.navigationBar.isHidden = false
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        
        mainView.nearHobbyCollectionView.rx.itemSelected
            .asDriver()
            .drive { [self] indexPath in
                let value = viewModel.model.nearFriends.value[indexPath.row].hf[0]
                print(value)
                var list = viewModel.model.myHobby.value
                if list.count < 8 && !list.contains(value) {
                    list.append(value)
                    viewModel.model.myHobby.accept(list)
                } else {
                    view.makeToast("추가할 수 없습니다.")
                }
            }
            .disposed(by: disposeBag)
        
        mainView.recommandCollectionView.rx.itemSelected
            .asDriver()
            .drive { [self] indexPath in
                let value = viewModel.model.fromRecomend.value[indexPath.row]
                
                var list = viewModel.model.myHobby.value
                if list.count < 8 && !list.contains(value) {
                    list.append(value)
                    viewModel.model.myHobby.accept(list)
                } else {
                    view.makeToast("추가할 수 없습니다.")
                }
            }
            .disposed(by: disposeBag)
    }
}

extension MainSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        var list = viewModel.model.myHobby.value
        let inputList = text
                            .split(separator: " ")
                            .map { String($0) }
                            .filter { !list.contains($0) }
        
        inputList.forEach {
            if list.count < 8 {
                list.append($0)
                viewModel.model.myHobby.accept(list)
            }
        }
        
        if inputList.count + list.count > 8 {
            view.makeToast("8개 이상 추가할 수 없습니다.")
        }
        
        searchBar.text = nil
    }
}

extension MainSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let state = (collectionView as! HobbyUICollectionView).state
        
        switch state {
        case .red:
            return viewModel.model.fromRecomend.value.count
        case .black:
            return viewModel.model.nearFriends.value.count > 8 ? 8 : viewModel.model.nearFriends.value.count
        case .green:
            return viewModel.model.myHobby.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let state = (collectionView as! HobbyUICollectionView).state
        
        let cell = mainView.recommandCollectionView.dequeueReusableCell(withReuseIdentifier: HobbyUICollectionViewCell.identifier, for: indexPath) as! HobbyUICollectionViewCell
        
        cell.state = state
        
        switch state {
        case .red:
            cell.hobbyLabel.text = viewModel.model.fromRecomend.value[indexPath.row]
        case .black:
            cell.hobbyLabel.text = viewModel.model.nearFriends.value[indexPath.row].hf[0]
        case .green:
            cell.hobbyLabel.text = viewModel.model.myHobby.value[indexPath.row]
            cell.deleteButton.rx.tap
                .single()
                .subscribe { [self] _ in
                    var hobbyList = viewModel.model.myHobby.value
                    hobbyList.remove(at: indexPath.row)
                    viewModel.model.myHobby.accept(hobbyList)
                    mainView.myFavoriteCollectionView.reloadData()
                }
                .disposed(by: disposeBag)
        }
        
        return cell
    }
}
