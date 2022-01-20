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

class PhoneNumberViewAuthViewController: BaseViewController {
    
    let viewModel = PhoneNumberAuthViewModel()
    
    let mainView = PhoneNumberAuthView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전화번호 텍스트필드 설정
        setPhoneNumberTextField()
        
        // 인증하기 메시지 버튼 설정
        setAuthMessageButton()
    }
    
    // 전화번호 텍스트필드 설정
    func setPhoneNumberTextField() {
        // 델리게이트 설정
        mainView.phoneNumberTextField.textField.delegate = self

        // 전화번호 ViewModel에 바인딩
        mainView.phoneNumberTextField.textField.rx.text
            .orEmpty
            .map { $0.replacingOccurrences(of: "-", with: "") } // 하이픈 제거
//            .subscribe({ value in
//                print("value = ", value)
//            })
//            .bind(to: { value in
//                print("value = ", value)
//            })
            .bind(to: viewModel.phoneNumber)
            .disposed(by: disposeBag)

        // TextField값을 정규식으로 체크해서 버튼 상태 변경
        mainView.phoneNumberTextField.textField.rx.text
            .orEmpty
            .map { $0.validPhoneNumber() }
            .bind { [self] value in
                if value {
                    mainView.authMessageButton.backgroundColor = .slpGreen
                } else {
                    mainView.authMessageButton.backgroundColor = .slpGray6
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 인증하기 메시지 버튼 설정
    func setAuthMessageButton() {
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
                            view.makeToast("성공")
                            self.navigationController?.pushViewController(AuthNumberViewController(), animated: true)
                        case .tooManyRequests:
                            view.makeToast("많은 요청")
                        case .unknownError:
                            view.makeToast("알 수 없는 오류")
                        }
                    }
                } else { // 만약 형식을 맞추지 않았다면
                    view.makeToast("잘못된 전화번호 형식입니다.")
                }
            }
            .disposed(by: disposeBag)
    }
}

extension PhoneNumberViewAuthViewController: UITextFieldDelegate {
    
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
        viewModel.phoneNumber.accept(textField.text!.replacingOccurrences(of: "-", with: ""))
        mainView.phoneNumberTextField.textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        
        print(textField.text?.count)
        
        let count = textField.text?.count ?? 0
        if count >= 13 && mainView.phoneNumberTextField.textField.text!.validPhoneNumber() {
            mainView.authMessageButton.backgroundColor = .slpGreen
        } else {
            mainView.authMessageButton.backgroundColor = .slpGray6
        }

        // RX가 안됨
        return false
        
//        print(range)
//        print("aaa = ", range.description)
//        print("index = ", range.location)
//        // 배열로 변환
//        let str = textField.text ?? ""
//        var arr = str.map { String($0) }
//        arr.append(string)
//
////        if textField.text!.count > 1 {
////        let abc = textField.text!.index(textField.text!.startIndex, offsetBy: range.location)
//            print("textField.indexVlaue = ", arr[range.location])
//
////        }
//
//        print("string = ", string)
//
        // 백스페이스를 입력했다면 11개를 입력하든말든 무조건 지울 수 있게 설정
        guard let char = string.cString(using: String.Encoding.utf8) else { return false }
        let isBackSpace = strcmp(char, "\\b")   // 입력값을 받아옴
//
//        // 11개 이상으로 입력하거나, 문자를 입력하는 경우 false 리턴
//        if (textField.text?.count == 13 || Int(string) == nil) && isBackSpace != -92 {
//            return false
//        }
//
//        // MARK: 순서대로 입력하면 가능한 코드
//        if (range.location == 3 || range.location == 8) && isBackSpace != -92 {
//            textField.text = "\(textField.text!)-\(string)"
//            return false
//        }
//
//        if (range.location == 4 || range.location == 9) && isBackSpace == -92 {
//            let text = textField.text!
//            let index = text.lastIndex(of: "-")!
//            textField.text = String(text[..<index])
//
//            return false
//        }
//
//
//
//
////        // 그냥 문자열을 수정해주는방향으로 가보자
////        let text = textField.text!
////        var mText = text.replacingOccurrences(of: "-", with: "")
////        print("mText = ", mText)
////
////        // 백스페이스를 입력했다면
////        if isBackSpace == -92 {
////            if mText.count > 0 {
////                mText = String(mText[..<mText.endIndex])
////                print("mText 수정 = ", mText)
////            }
////        }
////
////        if mText.count == 3 {
////            let index = mText.index(mText.startIndex, offsetBy: 3)
////            mText = String(mText[..<index]) + "-" + String(mText[index...]) + string
////            textField.text = mText
////            return false
////        }
////        }
////        let text = textField.text!
////        if let index = text.lastIndex(of: "-") {
////            let lastIndex = text.endIndex
////            if index == lastIndex {
////                textField.text = String(text[..<index])
////                return false
////            }
////        }
////        if text.count > 3 {
////            var value = String(text[..<3]) + "-"
////        }
////        textField.text = String(text[..<index])
        
        
        

         return true
    }
}
