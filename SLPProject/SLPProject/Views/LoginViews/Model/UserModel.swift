//
//  UserModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/25.
//

import Foundation
import RxRelay

class UserModel {
    static let shared = UserModel()
    
    let phoneNumber = BehaviorRelay<String>(value: "1099009603")
    let authNumber = BehaviorRelay<String>(value: "")
    let nickname = BehaviorRelay<String>(value: "닉네임")
    let birthday = BehaviorRelay<Date>(value: Date())
    let email = BehaviorRelay<String>(value: "email@gmail.com")
    let gender = BehaviorRelay<GenderType>(value: .none)
    
    // 싱글톤으로 처리할 때는 외부에서 인스턴스화 시키면 안되기 때문에 private로 생성자를 적어줘야함
    private init() { }
}
