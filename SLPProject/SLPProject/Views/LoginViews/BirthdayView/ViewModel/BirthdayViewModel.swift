//
//  BirthdayViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import Foundation
import RxRelay

class BirthdayViewModel {
    let year = BehaviorRelay<Int>(value: Date().year)
    let month = BehaviorRelay<Int>(value: Date().month)
    let day = BehaviorRelay<Int>(value: Date().day)
}
