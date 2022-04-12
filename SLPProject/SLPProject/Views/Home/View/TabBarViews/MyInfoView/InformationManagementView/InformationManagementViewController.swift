//
//  InformationManagementViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import RxSwift
import RxGesture
import MultiSlider
import Toast

class InformationManagementViewController: BaseViewController {
    
    let mainView = InformationManagerView()
    
    let viewModel = UserViewModel()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // state 변수 구독
        viewModel.userAPI.state
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .success:
                    self?.view.makeToast("성공")
                    self?.navigationController?.popViewController(animated: true)
                case .successDeRegister:
                    self?.changeRootView(OnboardingViewController())
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        // 상태정보 바인딩
        bindState()
        
        // 사용자 정보 가져오기
        setUserInformation()
        
        // 내비게이션바 설정
        setNavigationBar()
        
        // 컬렉션뷰 기본 설정
        setCollectionView()

        // 성별 버튼 클릭 처리
        setGenderButton()
        
        // 회원탈퇴버튼 클릭
        setDeRegisterButton()
    }
    
    // 상태정보 바인딩
    private func bindState() {
        
        viewModel.user.nickname
            .subscribe { [self] value in
                // 이름 변경
                mainView.profileView.profileUserNameView.userNameLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.user.reputation
            .subscribe { [self] value in
                // 새싹 타이틀
//                mainView.profileView.profileTitleView.cellState = value
            }
            .disposed(by: disposeBag)
        
        viewModel.user.comments
            .subscribe { [self] value in
                // 새싹 리뷰
                mainView.profileView.profileCommentView.comments = value
            }
            .disposed(by: disposeBag)
        
        viewModel.user.gender
            .subscribe { [self] value in
                // 내 성별
                mainView.selectGenderView.genderState = value
            }
            .disposed(by: disposeBag)
        
        viewModel.user.hobby
            .subscribe { [self] value in
                // 자주 하는 취미
                mainView.favoriteHabitView.habitTextField.textField.text = value
            }
            .disposed(by: disposeBag)
        
        // 자주 하는 취미 입력하면 뷰모델 데이터 업데이트
        mainView.favoriteHabitView.habitTextField.textField.rx.text
            .orEmpty
            .bind { [self] in viewModel.user.hobby.accept($0) }
            .disposed(by: disposeBag)
        
        viewModel.user.toggleState
            .subscribe { [self] value in
                // 검색 허용
                mainView.phoneSearchView.toggleSwitch.isOn = value == 1
            }
            .disposed(by: disposeBag)
        
        // 검색 변경되었을 때
        mainView.phoneSearchView.toggleSwitch.addTarget(self, action: #selector(toggleButtonChange(_:)), for: .valueChanged)
        
        viewModel.user.age
            .subscribe { [self] value in
                // 상대방 연령대
                mainView.searchAgeView.sliderValue = value.map { CGFloat($0) }
            }
            .disposed(by: disposeBag)
        
        // 연령대 변경되었을 때
        mainView.searchAgeView.ageSlider.addTarget(self, action: #selector(ageSliderValueChanged(_:)), for: .valueChanged)
        
        viewModel.userAPI.userResult
            .subscribe(onNext: { [self] user in
                // 이름 변경
                viewModel.user.nickname.accept(user.nick)
                
                // 새싹 타이틀
                viewModel.user.reputation.accept(user.reputation)
                
                // 새싹 리뷰
                viewModel.user.comments.accept(user.comment)
                
                // 내 성별
                viewModel.user.gender.accept(GenderType(rawValue: user.gender)!)
                
                // 자주 하는 취미
                viewModel.user.hobby.accept(user.hobby)
                
                // 검색 허용
                viewModel.user.toggleState.accept(user.searchable)
                
                // 상대방 연령대
                viewModel.user.age.accept([user.ageMin, user.ageMax])

            })
            .disposed(by: disposeBag)
    }
    
    // 사용자 정보 가져오기
    private func setUserInformation() {
        viewModel.userAPI.getUser()
    }
    
    // 내비게이션바 설정
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked(_:)))
    }
    
    // 컬렉션뷰 기본 설정
    private func setCollectionView() {
//        mainView.profileView.profileTitleView.titleCollectionViews.delegate = self
//        mainView.profileView.profileTitleView.titleCollectionViews.dataSource = self
//        mainView.profileView.profileTitleView.titleCollectionViews.register(ProfileTitleViewCell.self, forCellWithReuseIdentifier: ProfileTitleViewCell.identifier)
    }
    
    // 성별 버튼 클릭 처리
    private func setGenderButton() {
        mainView.selectGenderView.manButton.addTarget(self, action: #selector(genderButtonClicked(_:)), for: .touchUpInside)
        mainView.selectGenderView.womanButton.addTarget(self, action: #selector(genderButtonClicked(_:)), for: .touchUpInside)
    }
    
    // 성별버튼 클릭했을 때
    @objc private func genderButtonClicked(_ sender: UIButton) {
        if sender.titleLabel?.text == "남자" {
            viewModel.user.gender.accept(.man)
        } else {
            viewModel.user.gender.accept(.woman)
        }
    }
    
    // 토글버튼 변경했을 때
    @objc private func toggleButtonChange(_ sender: UISwitch) {
        viewModel.user.toggleState.accept(sender.isOn ? 1 : 0)
    }
    
    // 슬라이더 변경했을 때
    @objc private func ageSliderValueChanged(_ sender: MultiSlider) {
        viewModel.user.age.accept(sender.value.map { Int($0) })
    }
    
    // 회원탈퇴버튼 클릭
    private func setDeRegisterButton() {
        let vc = CustomAlertViewController()
        vc.state
            .subscribe(onNext: { [weak self] state in
                if state {
                    // 회원탈퇴
                    self?.viewModel.userAPI.withdrawUser()
                }
            })
            .disposed(by: disposeBag)
        
        mainView.deRegisterView.rx.tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                vc.modalPresentationStyle = .overCurrentContext
                self?.present(vc, animated: false, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
}

extension InformationManagementViewController {
    @objc func saveButtonClicked(_ sender: UIBarButtonItem) {
        viewModel.userAPI.updateMyPage()
    }
}
