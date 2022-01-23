//
//  Date+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import Foundation

extension Date {
    
    var year: Int {
            return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
}
