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
    
    let phoneNumber = BehaviorRelay<String>(value: "1092293212")
    let authNumber = BehaviorRelay<String>(value: "")
    let nickname = BehaviorRelay<String>(value: "")
    let birthday = BehaviorRelay<Date>(value: Date())
    let email = BehaviorRelay<String>(value: "email@gmail.com")
    let gender = BehaviorRelay<GenderType>(value: .none)
    
    let reputation = BehaviorRelay<[Int]>(value: [0, 0, 0, 0, 0, 0])
    let comments = BehaviorRelay<[String]>(value: [])
    let hobby = BehaviorRelay<String>(value: "")
    let toggleState = BehaviorRelay<Int>(value: 0)
    let age = BehaviorRelay<[Int]>(value: [18, 65])
    
    func fetchData(_ data: UserInformation) {
        phoneNumber.accept(data.phoneNumber)
        nickname.accept(data.nick)
        email.accept(data.email)
        gender.accept(GenderType(rawValue: data.gender)!)
        reputation.accept(data.reputation)
        comments.accept(data.comment)
        hobby.accept(data.hobby)
        toggleState.accept(data.searchable)
        age.accept([data.ageMin, data.ageMax])
        
    }
    
    // 싱글톤으로 처리할 때는 외부에서 인스턴스화 시키면 안되기 때문에 private로 생성자를 적어줘야함
    private init() { }
}
