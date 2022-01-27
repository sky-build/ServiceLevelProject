//
//  NetworkMonitor.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import Foundation
import Network
import RxRelay

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor = NWPathMonitor()
    let connectionState = BehaviorRelay<Bool>(value: false)
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType:ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    public func startMonitoring(){
        // 지속적으로 모니터링
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            print("path :\(path)")

            self?.isConnected = path.status == .satisfied
            self?.connectionType(path)
            
            if self?.isConnected == true{
                print("연결이된 상태임!")
            }else{
                print("연결 안된 상태임!")

            }
        }
    }
    
    public func stopMonitoring(){
        print("stopMonitoring 호출")
        monitor.cancel()
    }
    
    
    private func connectionType(_ path: NWPath) {
        print("getConenctionType 호출")
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("wifi에 연결")

        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")

        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("wiredEthernet에 연결")

        }else {
            connectionType = .unknown
            print("unknown ..")
        }
    }
}
