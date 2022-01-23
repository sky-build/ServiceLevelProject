//
//  NicknameViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import Foundation
import RxRelay

class NicknameViewModel {
    var nickname = BehaviorRelay<String>(value: "")
}
