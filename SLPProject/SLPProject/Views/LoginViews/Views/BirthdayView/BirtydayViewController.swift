//
//  BirtydayViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift

class BirthdayViewController: BaseViewController {
    
    let viewModel = UserViewModel()
    
    let mainView = BirthdayView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰모델에 생일 바인딩
        bindBirthday()
        
        // 다음버튼 클릭했을 때 설정
        setNextButton()
        
        // 데이터피커 addtarget 설정
        mainView.datePicker.addTarget(self, action: #selector(datePickerSelected(_:)), for: .valueChanged)
    }
    
    // 뷰모델에 생일 바인딩
    private func bindBirthday() {
        viewModel.user.birthday
            .bind { [self] date in
                mainView.dateLabel.yearView.dateLabel.text = "\(date.year)"
                mainView.dateLabel.montyView.dateLabel.text = "\(date.month)"
                mainView.dateLabel.dayView.dateLabel.text = "\(date.day)"
            }
            .disposed(by: disposeBag)
    }
    
    // 다음버튼 클릭했을 때 설정
    private func setNextButton() {
        mainView.nextButton.rx.tap
            .bind { [self] _ in
                // 날짜를 선택했는지 먼저 검사
                if mainView.state {
                    // 날짜가 유효한지 먼저 검사(17살 이상인지 검사)
                    let birthday = viewModel.user.birthday.value
                    if koreanAge(year: birthday.year, month: birthday.month, day: birthday.day) >= 17 {
                        navigationController?.pushViewController(EmailViewController(), animated: true)
                    } else {
                        view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다.")
                    }
                    
                } else {
                    view.makeToast("생일을 선택해주세요")
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func datePickerSelected(_ sender: UIDatePicker) {
        let date = sender.date
        
        // 날짜 업데이트
        viewModel.user.birthday.accept(date)
        
        // 색상을 바꾸는 코드는 한번만 실행하도록 설정
        if !mainView.state {
            mainView.state.toggle()
        }
    }
    
    // 만 나이 계산
    private func koreanAge(year: Int, month: Int, day: Int) -> Int {
        // 현재 날짜
        let date = Date()
        
        // 만 나이 계산(태어난날보다 오늘이 더 이전이라면 1 빼줌)
        var result = 0
        if (month > date.month) || ((date.month == month) && (day > date.day)) {
            result = 1
        }
        
        return (date.year - year) - result
    }
}
