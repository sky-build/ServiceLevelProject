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

class PhoneNumberViewAuthViewController: UIViewController {
    
    let viewModel = PhoneNumberAuthViewModel()
    
    let mainView = PhoneNumberAuthView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames {
          print(family)

          for sub in UIFont.fontNames(forFamilyName: family) {
            print("====> \(sub)")
          }
        }
        
        view.backgroundColor = .white
        
        // 전화번호 ViewModel에 바인딩
        mainView.phoneNumberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumber)
            .disposed(by: disposeBag)
        
        // TextField값을 정규식으로 체크해서 버튼 상태 변경
        mainView.phoneNumberTextField.rx.text
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
        
        // 인증하기 버튼 클릭했을 경우
        mainView.authMessageButton.rx.tap
            .map { self.mainView.phoneNumberTextField.text!.validPhoneNumber() }
            .bind { [self] state in
                
                // 번호를 제대로 입력한 경우 전화번호 인증 수행
                if state {
                    view.makeToast("전화번호 인증 시작")
                    switch viewModel.sendPhoneAuthorization() {
                    case .success:
                        view.makeToast("성공")
                    case .tooManyRequests:
                        view.makeToast("많은 요청")
                    case .unknownError:
                        view.makeToast("알 수 없는 오류")
                    }
                } else { // 만약 형식을 맞추지 않았다면
                    view.makeToast("잘못된 전화번호 형식입니다.")
                }
            }
            .disposed(by: disposeBag)
    }
}
