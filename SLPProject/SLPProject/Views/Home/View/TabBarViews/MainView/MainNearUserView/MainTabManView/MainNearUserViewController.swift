//
//  MainNearUserViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/15.
//

import UIKit
import Tabman
import Pageboy

class MainNearUserViewController: TabmanViewController {
    
    private var viewControllers = [MainNearSeSACViewController(), MainRequestedViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        
        // 탭바 배경색 변경
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .clear
        
        // 인디케이터 두께
        bar.indicator.weight = .light
        bar.indicator.tintColor = .slpGreen
        
        // 버튼 설정
        bar.buttons.customize { (button) in
            button.tintColor = .slpGray6
            button.selectedTintColor = .slpGreen
            button.font = .Title4_R14
        }
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
    
}

extension MainNearUserViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = index == 0 ? "주변 새싹" : "받은 요청"
        return TMBarItem(title: title)
    }
}
