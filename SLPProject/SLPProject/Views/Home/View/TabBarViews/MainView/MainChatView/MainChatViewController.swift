//
//  MainChatViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/18.
//

import UIKit
import SnapKit
import GrowingTextView

class MainChatViewController: BaseViewController {
    
    let mainView = MainChatView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.chatView.textView.delegate = self
    }
    
}

extension MainChatViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        print("높이 변경 - ", height)
        
//        if height < 60 {
            mainView.chatView.snp.updateConstraints {
                print("높이 변경되나?")
                $0.height.equalTo(height + 22)
            }
//            mainView.chatView.textView.isScrollEnabled = false
//        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

//extension MainChatViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
////        let size = CGSize(width: view.frame.width, height: .infinity)
////        let estimateSize = textView.sizeThatFits(size)
////
////        textView.constraints.forEach { (constraint) in
////            if constraint.firstAttribute == .height {
////                constraint.constant = estimateSize.height
////            }
////        }
//        let fixedWidth = textView.frame.size.width
//        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//    }
//}

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
