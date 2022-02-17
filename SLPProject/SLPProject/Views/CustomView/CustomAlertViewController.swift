//
//  CustomAlertViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/06.
//

import UIKit
import SnapKit
import RxRelay

enum AlertViewStateEnum {
    case deRegister
    case requestFriends
}

class CustomAlertViewController: UIViewController, FetchViews {
    
    let state = PublishRelay<Bool>()
    
    var viewState: AlertViewStateEnum = .deRegister {
        didSet {
            switch viewState {
            case .deRegister:
                titleLabel.text = "정말 탈퇴하시겠습니까?"
                subTitleLabel.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
            case .requestFriends:
                titleLabel.text = "취미 같이 하기를 요청할게요!"
                subTitleLabel.text = "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요"
            }
        }
    }
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Body1_M16
        label.text = "정말 탈퇴하시겠습니까?"
        label.textAlignment = .center
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Body3_R14
        label.text = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
        label.textAlignment = .center
        return label
    }()
    
    let cancelButton: CusomButton = {
        let button = CusomButton()
        button.layer.cornerRadius = 8
        button.buttonState = false
        button.setTitle("취소", for: .normal)
        return button
    }()
    
    let okButton: CusomButton = {
        let button = CusomButton()
        button.layer.cornerRadius = 8
        button.buttonState = true
        button.setTitle("확인", for: .normal)
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.alignment = .fill    // 가운데 채움
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addViews()
        makeConstraints()
    }
    
    func addViews() {
        view.addSubview(backgroundView)
        
        [cancelButton, okButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [titleLabel, subTitleLabel, buttonStackView].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16.5)
            $0.height.equalTo(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16.5)
            $0.height.equalTo(22)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
    
    @objc private func buttonClicked(_ sender: UIButton) {
        let userState = sender.titleLabel?.text == "확인"
        state.accept(userState)
        self.dismiss(animated: false, completion: nil)
    }
}
