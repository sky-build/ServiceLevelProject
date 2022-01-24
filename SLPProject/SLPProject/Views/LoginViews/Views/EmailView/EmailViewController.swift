//
//  EmailViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift

class EmailViewController: BaseViewController {
    
    let viewModel = LoginViewModel()
    
    let mainView = EmailView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이메일텍스트필드 설정
        setEmailTextView()
        
        // 버튼 클릭 설정
        setNextButton()
    }
    
    // 이메일텍스트필드 설정
    private func setEmailTextView() {
        // 키보드가 올라온 상태여야함
        mainView.emailTextField.textField.becomeFirstResponder()
        
        // 이메일 텍스트 뷰모델에 바인딩
        mainView.emailTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        mainView.emailTextField.textField.rx.text
            .orEmpty
            .map { $0.validEmail() }    // 유효한 이메일인지 먼저 검사
            .bind { [self] state in
                if state {  // 유효한 이메일이면
                    mainView.nextButton.backgroundColor = .slpGreen
                } else {
                    mainView.nextButton.backgroundColor = .slpGray6
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 버튼 클릭 설정
    private func setNextButton() {
        mainView.nextButton.rx.tap
            .map { [self] in mainView.emailTextField.textField.text?.validEmail() ?? false }
            .bind { [self] state in
                if state {
                    navigationController?.pushViewController(GenderSelectViewController(), animated: true)
                } else {
                    view.makeToast("이메일 형식이 올바르지 않습니다.")
                }
            }
            .disposed(by: disposeBag)
    }
}
