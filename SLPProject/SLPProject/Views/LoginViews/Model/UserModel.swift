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
    
    let phoneNumber = BehaviorRelay<String>(value: "")
    let authNumber = BehaviorRelay<String>(value: "")
    let nickname = BehaviorRelay<String>(value: "")
    let birthday = BehaviorRelay<Date>(value: Date())
    let email = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<GenderType>(value: .none)
}
