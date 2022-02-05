//
//  InformationManagementViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/04.
//

import RxRelay

class InformationManagementModel {
    
    static let shared = InformationManagementModel()
    
    let userName = BehaviorRelay<String>(value: "")
    let reputation = BehaviorRelay<[Int]>(value: [0, 0, 0, 0, 0, 0])
    let comments = BehaviorRelay<[String]>(value: [])
    let hobby = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<GenderType>(value: .none)
    let toggleState = BehaviorRelay<Int>(value: 0)
    let age = BehaviorRelay<[Int]>(value: [18, 65])
    
    private init() { }
}
