//
//  String+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/18.
//

import Foundation

extension String {
    func validPhoneNumber() -> Bool {
        let emailRegex = "^010-?([0-9]{4})-?([0-9]{4})"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
