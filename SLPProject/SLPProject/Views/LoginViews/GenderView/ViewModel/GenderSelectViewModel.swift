//
//  GenderViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import Foundation
import RxRelay

class GenderSelectViewModel {
    var gender = BehaviorRelay<GenderType>(value: .none)
}
