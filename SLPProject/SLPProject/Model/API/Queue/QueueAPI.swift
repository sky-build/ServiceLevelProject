//
//  QueueAPI.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxRelay

private enum QueueEnum: Int {
    case noConnectinon = 0   // enum 처리
    case success = 200
    case moreThreeReportUser = 201
    case penaltyGradeOne = 203
    case penaltyGradeTwo = 204
    case penaltyGradeThree = 205
    case noGenderSelect = 206
    case firebaseTokenError = 401
    case noRegisterUser = 406
    case serverError = 500
    case clientError = 501
}

private enum QueueURL: String {
    case queue = "queue"
    case onqueue = "queue/onqueue"
}

extension QueueURL {
    var url: URL {
        URL(string: BaseAPI.baseURL + self.rawValue)!
    }
}

class QueueAPI {
    
    // API상태 업데이트
    let state = PublishRelay<QueueAPIResult>()

    private var disposeBag = DisposeBag()
    
    // 기본 코드
    fileprivate func baseQueueAPIRequest(method: HTTPMethod, url: URL, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (Data?, QueueEnum) -> Void) {
        if NetworkMonitor.shared.isConnected {
            RxAlamofire.requestData(method, url, parameters: parameters, headers: header)
                .debug()
                .subscribe { (header, data) in
                    // APIState를 Enum으로 변경
                    let apiState = QueueEnum(rawValue: header.statusCode)!
                    
                    completion(data, apiState)
                }
                .disposed(by: disposeBag)
        } else {
            completion(nil, .noConnectinon)
        }

    }
    
    func queue() {
        let parameters: Parameters = [
              "type": 2,
              "region": 1274830692,
              "long": 126.92983890550006,
              "lat": 37.482733667903865,
              "hf": ["Anything", "coding"]
        ]
        
        baseQueueAPIRequest(method: .post, url: QueueURL.queue.url, parameters: parameters, header: BaseAPI.header) { [self] (data, apiState) in
            switch apiState {
            case .noConnectinon:
                break
            case .success:
                state.accept(.success)
            case .moreThreeReportUser:
                state.accept(.moreThreeReportUser)
            case .penaltyGradeOne:
                state.accept(.penaltyGradeOne)
            case .penaltyGradeTwo:
                state.accept(.penaltyGradeTwo)
            case .penaltyGradeThree:
                state.accept(.penaltyGradeThree)
            case .noGenderSelect:
                state.accept(.noGenderSelect)
            case .firebaseTokenError:
                FirebaseToken.shared.updateIDToken {
                    queue()
                }
            case .noRegisterUser:
                state.accept(.noRegisterUser)
            case .serverError:
                state.accept(.serverError)
            case .clientError:
                state.accept(.clientError)
            }
        }
    }
    
    func onQueue() {
        let parameters: Parameters = [
            "region": 1274830692,
            "lat": 37.482733667903865,
            "long": 126.92983890550006
        ]
        
        baseQueueAPIRequest(method: .post, url: QueueURL.onqueue.url, parameters: parameters, header: BaseAPI.header) { [self] (data, apiState) in
            switch apiState {
            case .noConnectinon:
                state.accept(.noConnectinon)
            case .success:
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(FriendsData.self, from: data)
                    // 모델에 값 변경해줌
                    MainModel.shared.nearFriends.accept(decodeData.fromQueueDB)
                    MainModel.shared.fromRecomend.accept(decodeData.fromRecommend)
                    
                    // 그리고 구독하라고 설정
                    state.accept(.success)
                } catch {
                    print("decode error")
                }
                state.accept(.success)
            case .firebaseTokenError:
                state.accept(.firebaseTokenError)
            case .noRegisterUser:
                state.accept(.noRegisterUser)
            case .serverError:
                state.accept(.serverError)
            case .clientError:
                state.accept(.clientError)
            default:
                break
            }
        }
    }
    
}
