//
//  MainChatViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit
import GrowingTextView
import RxSwift
import RxCocoa

class MainChatViewController: BaseViewController {
    
    let mainView = MainChatView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        setTextView()
        
        mainView.chatView.sendButton.rx.tap
            .subscribe { [self] _ in
                switch mainView.chatView.sendButtonState {
                case .enable:
                    print("가능")
                case .disable:
                    print("불가능")
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func setTextView() {
        mainView.chatView.textView.delegate = self
    }
}

extension MainChatViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        
        mainView.chatView.snp.updateConstraints {
            $0.height.equalTo(height + 15)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        mainView.chatView.sendButtonState = textView.text == "" ? .disable : .enable
    }
}

extension MainChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainMyChatTableViewCell.identifier, for: indexPath) as! MainMyChatTableViewCell
            
            cell.date.text = "15:02"
            cell.chatView.text.text = "안녕하세요! 저 평일은 저녁 8시에 꾸준히 타는데 7시부터 타도 괜찮아요안녕하세요! 저 평일은 저녁 8시에 꾸준히 타는데 7시부터 타도 괜찮아요"
            cell.readState = .read
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFriendChatTableViewCell.identifier, for: indexPath) as! MainFriendChatTableViewCell
            
            cell.date.text = "15:02"
            cell.chatView.text.text = "안녕하세요! 저 평일은 저녁 8시에 꾸준히 타는데 7시부터 타도 괜찮아요안녕하세요! 저 평일은 저녁 8시에 꾸준히 타는데 7시부터 타도 괜찮아요"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIImageView()
        view.image = UIImage(named: "notice")
        view.contentMode = .scaleAspectFit
        return view
    }
}
