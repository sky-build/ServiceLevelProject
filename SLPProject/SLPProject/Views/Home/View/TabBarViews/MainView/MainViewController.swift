//
//  MainViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import MapKit
import SnapKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // filterButton 설정
        setFilterButtons()
    }
    
    // filterButton 설정
    private func setFilterButtons() {
        mainView.filterButton.allButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.manButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.womanButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func filterButtonClicked(_ sender: UIButton) {
        let title = sender.currentTitle!
        switch title {
        case "전체":
            mainView.filterButton.selectButton = .all
        case "남자":
            mainView.filterButton.selectButton = .man
        case "여자":
            mainView.filterButton.selectButton = .woman
        default:
            break
        }
    }
}
