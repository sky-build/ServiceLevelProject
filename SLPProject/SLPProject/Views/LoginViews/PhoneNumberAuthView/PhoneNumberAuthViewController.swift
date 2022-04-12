//
//  PhoneNumberAuthViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import UIKit
import RxCocoa
import RxSwift
import Toast
import AnyFormatKit

class PhoneNumberAuthViewController: BaseViewController {
    
    let viewModel = UserViewModel()
    
    let mainView = PhoneNumberAuthView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FirebaseToken.shared.updateIDToken{}
//        FirebaseToken.shared.updateFCMToken {}
        
        // 전화번호 텍스트필드 설정
        setPhoneNumberTextField()
        
        // 인증하기 메시지 버튼 설정
        setAuthMessageButton()
    }
    
    // 전화번호 텍스트필드 설정
    private func setPhoneNumberTextField() {
        // 델리게이트 위임
        mainView.phoneNumberTextField.textField.delegate = self
    }
    // cx2rCtnmHEnfkEvPDNsH6l:APA91bHY1_hVScbReHGhlRwmK7Y3wLCOrPSXvZzd_jMiUXCdefiWTHiBlpp86UfDpasKyqI5eCwe-QD_igY4QmnoUeqwXW34mWc1bNVLHyCy1k4N4MxMxXqVVI3EEGrICnqFjJWO5bmz
    
    // 인증하기 메시지 버튼 설정
    private func setAuthMessageButton() {
        // 입력값 뷰모델에 바인딩
//        mainView.phoneNumberTextField.textField.rx.text
//            .orEmpty
//            .bind(to: viewModel.user.phoneNumber)
//            .disposed(by: disposeBag)
        
        // 인증하기 버튼 클릭했을 경우
        mainView.authMessageButton.rx.tap
            .map { self.mainView.phoneNumberTextField.textField.text!.validPhoneNumber() }
            .bind { [self] state in
                // 번호를 제대로 입력한 경우 전화번호 인증 수행
                if state {
                    view.makeToast("전화번호 인증 시작")
                    viewModel.sendPhoneAuthorization { state in
                        switch state {
                        case .success:
                            let vc = AuthNumberViewController()
                            vc.toastText = "인증번호를 보냈습니다."
                            self.navigationController?.pushViewController(vc, animated: true)
                        case .tooManyRequests:
                            view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해주세요.")
                        case .unknownError:
                            view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                        default:
                            break
                        }
                    }
                } else { // 만약 형식을 맞추지 않았다면
                    view.makeToast("잘못된 전화번호 형식입니다.")
                }
            }
            .disposed(by: disposeBag)
    }
}

extension PhoneNumberAuthViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }

        let formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        
        viewModel.user.phoneNumber.accept(textField.text!.replacingOccurrences(of: "-", with: ""))
        
        mainView.phoneNumberTextField.textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        
        // 글자가 13자 이상 입력안되게 설정
        // 만약 유효한 값이라면 버튼값 변경
        let count = textField.text?.count ?? 0
        if count >= 13 && mainView.phoneNumberTextField.textField.text!.validPhoneNumber() {
            mainView.authMessageButton.backgroundColor = .slpGreen
        } else {
            mainView.authMessageButton.backgroundColor = .slpGray6
        }

        return false
    }
}
