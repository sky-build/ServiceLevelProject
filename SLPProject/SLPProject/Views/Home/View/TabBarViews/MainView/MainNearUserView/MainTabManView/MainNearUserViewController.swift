//
//  MainNearUserViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/15.
//

import UIKit
import Tabman
import Pageboy
import RxSwift
import RxCocoa

class MainNearUserViewController: TabmanViewController, FetchViews {
    
    private var viewControllers = [MainNearSeSACViewController(), MainRequestedViewController()]
    
    let changeHobbyButton: CustomNextButton = {
        let button = CustomNextButton()
        button.titleLabel?.font = .Body3_R14
        button.setTitle("취미 변경", for: .normal)
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "refresh"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.slpGreen.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    let viewModel = MainViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "새싹 친구"
        
        self.dataSource = self
        
        // Set tabman
        setTabMan()

        addViews()
        makeConstraints()
        
        refreshButton.rx.tap
            .bind { [self] _ in
                viewModel.queueAPI.onQueue()
            }
            .disposed(by: disposeBag)
        
        changeHobbyButton.rx.tap
            .bind { [self] _ in
                navigationController?.pushViewController(MainSearchViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // Set tabman
    private func setTabMan() {
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
    
    func addViews() {
        [refreshButton, changeHobbyButton].forEach {
            view.addSubview($0)
        }
    }
    
    func makeConstraints() {
        refreshButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        changeHobbyButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(refreshButton.snp.leading).inset(-8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
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
