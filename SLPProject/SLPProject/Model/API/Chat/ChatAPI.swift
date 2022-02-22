//
//  ChatAPI.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/19.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxRelay

private enum ChatEnum: Int {
    case noConnectinon = 0   // enum 처리
    case success = 200
    case firebaseTokenError = 401
    case serverError = 500
    case clientError = 501
}

final class ChatAPI: BaseAPI {
    
    // API상태 업데이트
    let state = PublishRelay<QueueAPIResult>()

    private var disposeBag = DisposeBag()
    
    // 기본 코드
    fileprivate func baseChatAPIRequest(method: HTTPMethod, url: URL, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (Data?, ChatEnum) -> Void) {
        if NetworkMonitor.shared.isConnected {
            RxAlamofire.requestData(method, url, parameters: parameters, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: header)
                .debug()
                .subscribe { (header, data) in
                    // APIState를 Enum으로 변경
                    let apiState = ChatEnum(rawValue: header.statusCode)!
                    
                    completion(data, apiState)
                }
                .disposed(by: disposeBag)
        } else {
            completion(nil, .noConnectinon)
        }
    }
    
    func chatDataRequest() {
//        /chat/{from}?lastchatDate={lastchatDate}
        
        
    }
}
