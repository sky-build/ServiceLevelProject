//
//  String+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import Foundation

extension String {
    func validPhoneNumber() -> Bool {
        let phoneNumberRegex = "^010-?([0-9]{4})-?([0-9]{4})"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegex)
        return predicate.evaluate(with: self)
    }
    
    func validNickname() -> Bool {
        if self.count >= 1 && self.count <= 10 {
            return true
        }
        return false
    }
    
    func validEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
