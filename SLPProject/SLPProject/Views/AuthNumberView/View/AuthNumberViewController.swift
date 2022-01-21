//
//  AuthNumberViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/20.
//

import UIKit
import RxCocoa
import RxSwift

class AuthNumberViewController: BaseViewController {
    
    let viewModel = AuthNumberViewModel()
    
    let mainView = AuthNumberView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.numberTextField.textField.rx.text
                .orEmpty
                .bind(to: viewModel.authNumber)
                .disposed(by: disposeBag)
            
            mainView.authMessageButton.rx.tap
                .bind { [self] _ in
                    viewModel.authToken { state in
                        switch state {
                        case .success:
                            view.makeToast("성공")
                        case .tooManyRequests:
                        view.makeToast("많은 요청")
                    case .unknownError:
                        view.makeToast("알수 없는 오류")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        mainView.numberTextField.textField.delegate = self
        
        // 6개 입력하면 활성화
        mainView.numberTextField.textField.rx.text
            .orEmpty
            .map { $0.count >= 6 }
            .bind { [self] value in
                if value {
                    mainView.authMessageButton.backgroundColor = .slpGreen
                } else {
                    mainView.authMessageButton.backgroundColor = .slpGray6
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension AuthNumberViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 입력값 6개 이상일 경우 입력안되게 막음
        if (((textField.text?.count ?? 0) >= 6 || Int(string) == nil) && string != "") {
            return false
        }
        
        return true
    }
}
