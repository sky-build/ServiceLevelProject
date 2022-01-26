//
//  NicknameViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift

class NicknameViewController: BaseViewController {
    
    let viewModel = UserViewModel()
    
    let mainView = NicknameView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.nicknameViewModel = self
        
        // 데이터 바인딩
        dataBind()
        
        // 닉네임 설정
        setNickname()
        
        // 다음버튼 설정
        setNextButton()
    }
    
    // 데이터 바인딩
    func dataBind() {
        mainView.nicknameTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.user.nickname)
            .disposed(by: disposeBag)
    }
    
    // 닉네임 설정
    private func setNickname() {
        // 델리게이트 위임
        mainView.nicknameTextField.textField.delegate = self
        
        // 키보드가 올라온 상태여야함
        mainView.nicknameTextField.textField.becomeFirstResponder()
        
        // 1개 이상 입력하면 버튼색 변경
        mainView.nicknameTextField.textField.rx.text
            .orEmpty
            .map { $0.count >= 1 }
            .bind { [self] value in
                if value {
                    mainView.nextButton.backgroundColor = .slpGreen
                } else {
                    mainView.nextButton.backgroundColor = .slpGray6
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 다음버튼 설정
    private func setNextButton() {
        mainView.nextButton.rx.tap
            .map { [self] in mainView.nicknameTextField.textField.text?.validNickname() ?? false }
            .bind { [self] state in
                if state {
                    navigationController?.pushViewController(BirthdayViewController(), animated: true)
                } else {
                    view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요")
                }
            }
            .disposed(by: disposeBag)
    }
}

extension NicknameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 입력값 10개 이상일 경우 또는 입력안되게 막음
        if ((textField.text?.count ?? 0) >= 10) && string != "" {
            return false
        }
        
        return true
    }
}
