//
//  MainNearSeSACViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/16.
//

import UIKit

class MainNearSeSACViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainNearSeSACView()
    
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
    }
    
}

extension MainNearSeSACViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.nearFriends.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainNearSeSACTableViewCell.identifier, for: indexPath) as! MainNearSeSACTableViewCell
        
        cell.view.profileUserNameView.stratchButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        cell.view.profileUserNameView.userNameLabel.text = viewModel.model.nearFriends.value[indexPath.row].nick
        
        return cell
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        mainView.tableView.reloadData()
    }
}
