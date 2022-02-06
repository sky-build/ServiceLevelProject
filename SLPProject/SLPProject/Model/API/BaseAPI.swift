//
//  BaseAPI.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import Foundation
import Alamofire

struct BaseAPI {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    // 연산 프로퍼티 사용해야 idToken값이 지속적으로 변경됨
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": FirebaseToken.shared.idToken
        ]
    }
    
    
}
