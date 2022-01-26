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
}
