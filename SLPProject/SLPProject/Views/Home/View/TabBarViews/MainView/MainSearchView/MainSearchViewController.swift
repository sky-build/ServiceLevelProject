//
//  MainSearchViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import RxCocoa
import RxSwift

class MainSearchViewController: BaseViewController {
    
    let data = [
        "요가",
        "독서모임",
        "SeSAC",
        "코딩"
    ]
    
    let viewModel = MainViewModel()
    
    let mainView = MainSearchView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        
        mainView.recommandCollectionView.delegate = self
        mainView.recommandCollectionView.dataSource = self
//        mainView.recommandCollectionView.layoutIfNeeded()
        
        mainView.nearHobbyCollectionView.delegate = self
        mainView.nearHobbyCollectionView.dataSource = self
        
        mainView.myFavoriteCollectionView.delegate = self
        mainView.myFavoriteCollectionView.dataSource = self
        
//        viewModel.model.fromRecomend
//            .bind(to: mainView.recommandCollectionView.rx.items(cellIdentifier: HobbyUICollectionViewCell.identifier)) { row, element, cell in
//                cell
//
//            }
//            .disposed(by: disposeBag)
        
        mainView.nearHobbyCollectionView.rx.itemSelected
            .asDriver()
            .drive { [self] indexPath in
                print(viewModel.model.nearFriends.value[indexPath.row].hf[0])
                var list = viewModel.model.myHobby.value
                list.append(viewModel.model.nearFriends.value[indexPath.row].hf[0])
                viewModel.model.myHobby.accept(list)
                mainView.myFavoriteCollectionView.reloadData()
            }
            .disposed(by: disposeBag)

        
    }
}

extension MainSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let state = (collectionView as! HobbyUICollectionView).state
        
        switch state {
        case .red:
            return viewModel.model.fromRecomend.value.count
        case .black:
            return viewModel.model.nearFriends.value.count
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
        }
        
        return cell
    }
}
