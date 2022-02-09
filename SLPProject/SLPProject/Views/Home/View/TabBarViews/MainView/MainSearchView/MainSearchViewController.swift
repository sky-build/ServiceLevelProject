//
//  MainSearchViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit

class MainSearchViewController: BaseViewController {
    
    let data = [
        "요가",
        "독서모임",
        "SeSAC",
        "코딩"
    ]
    
    let viewModel = MainViewModel()
    
    let mainView = MainSearchView()
    
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

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension MainSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyUICollectionViewCell.identifier, for: indexPath) as! HobbyUICollectionViewCell
        
        cell.hobbyLabel.text = data[indexPath.row]
        if indexPath.row == 0 {
            cell.state = .red
        } else if indexPath.row == 1 {
            cell.state = .black
        } else {
            cell.state = .green
        }
        
        return cell
    }
}
