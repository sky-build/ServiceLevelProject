//
//  MainSearchViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard
import SnapKit
import Toast

final class MainSearchViewController: BaseViewController {
    
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
        
        // 키보드 설정
        setKeyboard()
        
        // 버튼 설정
        setButton()
    }
    
    // collectionView 설정
    private func setCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        viewModel.model.myHobby
            .subscribe { [self] value in
                print("데이터", viewModel.model.myHobby.value)
                mainView.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .filter { $0.section != 2 }
            .subscribe(onNext: { [self] indexPath in
                print("클릭한 데이터")
                print(indexPath.section, indexPath.row)
                if indexPath.section == 0 {
                    let value = viewModel.model.fromRecomend.value[indexPath.row]
                    
                    var list = viewModel.model.myHobby.value
                    if list.count < 8 && !list.contains(value) {
                        list.append(value)
                        viewModel.model.myHobby.accept(list)
                    } else {
                        view.makeToast("추가할 수 없습니다.")
                    }
                } else if indexPath.section == 1 {
                    let value = viewModel.model.nearFriends.value[indexPath.row].hf[0]
                    
                    var list = viewModel.model.myHobby.value
                    if list.count < 8 && !list.contains(value) {
                        list.append(value)
                        viewModel.model.myHobby.accept(list)
                    } else {
                        view.makeToast("추가할 수 없습니다.")
                    }
                }
            })
            .disposed(by: disposeBag)

    
        
//        mainView.nearHobbyCollectionView.rx.itemSelected
//            .asDriver()
//            .drive { [self] indexPath in
//                let value = viewModel.model.nearFriends.value[indexPath.row].hf[0]
//                print(value)
//                var list = viewModel.model.myHobby.value
//                if list.count < 8 && !list.contains(value) {
//                    list.append(value)
//                    viewModel.model.myHobby.accept(list)
//                } else {
//                    view.makeToast("추가할 수 없습니다.")
//                }
//            }
//            .disposed(by: disposeBag)
//
//        mainView.recommandCollectionView.rx.itemSelected
//            .asDriver()
//            .drive { [self] indexPath in
//                let value = viewModel.model.fromRecomend.value[indexPath.row]
//
//                var list = viewModel.model.myHobby.value
//                if list.count < 8 && !list.contains(value) {
//                    list.append(value)
//                    viewModel.model.myHobby.accept(list)
//                } else {
//                    view.makeToast("추가할 수 없습니다.")
//                }
//            }
//            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // searchBar 설정
    private func setSearchBar() {
        navigationController?.navigationBar.isHidden = false
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
    }
    
    // 키보드 설정
    private func setKeyboard() {
        RxKeyboard.instance.visibleHeight
            .drive { [self] height in
                if height == 0 {
                    mainView.bottomButton.layer.cornerRadius = 8
                    mainView.bottomButton.snp.updateConstraints {
                        $0.bottom.equalTo(view.safeAreaLayoutGuide)
                        $0.leading.trailing.equalToSuperview().inset(16)
                    }
                } else {
                    mainView.bottomButton.layer.cornerRadius = 0
                    mainView.bottomButton.snp.updateConstraints {
                        $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(height - view.safeAreaInsets.bottom)
                        $0.leading.trailing.equalToSuperview()
                    }
                }
                // 애니메이션
                view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
    }
    
    // 버튼 설정
    private func setButton() {
        mainView.bottomButton.rx.tap
            .subscribe { [self] _ in
                viewModel.queueAPI.queue()
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return viewModel.model.fromRecomend.value.count
        case 1:
            return viewModel.model.nearFriends.value.count > 8 ? 8 : viewModel.model.nearFriends.value.count
        case 2:
            print(viewModel.model.myHobby.value.count)
            return viewModel.model.myHobby.value.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("수정")
        
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyUICollectionViewCell.identifier, for: indexPath) as! HobbyUICollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell.hobbyLabel.text = viewModel.model.fromRecomend.value[indexPath.row]
            cell.state = .red
        case 1:
            cell.hobbyLabel.text = viewModel.model.nearFriends.value[indexPath.row].hf[0]
            cell.state = .black
        case 2:
            cell.hobbyLabel.text = viewModel.model.myHobby.value[indexPath.row]
            cell.state = .green
            cell.deleteButton.isHidden = false
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
        default:
            break
        }
        
        return cell
    }
    
    @objc func deleteButtonClicked(_ sender : UIButton) {
        mainView.collectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 2)])
        var hobbyList = viewModel.model.myHobby.value
        hobbyList.remove(at: sender.tag)
        viewModel.model.myHobby.accept(hobbyList)
    }
}
