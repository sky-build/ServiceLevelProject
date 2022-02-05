//
//  UserDefaultValues.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/06.
//

import Foundation

final class UserDefaultValues {
    
    // 회원가입상태 변수
    static var registerState: UserRegisterState {
        get {
            let state = UserDefaults.standard.string(forKey: "registerState") ?? UserRegisterState.beginner.rawValue
            return UserRegisterState(rawValue: state)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "registerState")
        }
    }
    
    
}
