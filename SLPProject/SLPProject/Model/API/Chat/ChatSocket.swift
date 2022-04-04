//
//  ChatSocket.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/22.
//

import Foundation
import SocketIO

//class ChatSocket: NSObject {
//    
////    static let shared = ChatSocket()
////    private init() {}
//    
//    var manager = SocketManager(socketURL: URL(string: "http://192.168.0.4:3000")!, config: [.log(true) , .compress])
//    var socket: SocketIOClient!
//
//    override init() {
//        super.init()
//        
//        socket = manager.socket(forNamespace: "/")
//        
//        socket.on(clientEvent: .connect) { data, ack in
//            print("socket is connected", data, ack)
////            self.socket.emit("changesocketid", "2P5l9BKOVcQPnpWS15OL0wHhyi13")
//        }
//        
//        socket.on(clientEvent: .disconnect) { data, ack in
//            print("socket is disconnected", data, ack)
//        }
//        
//        socket.on("test") { (dataArray, ack) in
//            print("데이터 도착")
//            print(dataArray)
//        }
//    }
//    
//    func emit() {
//        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
//    }
//    
//    func state() {
//        print("현재상태: ", socket.status)
//    }
//    
//    func establishConnection() {
//        print("연결시도")
//        socket.connect()
//        print("소켓상태: ", socket.status)
//    }
//    
//    func closeConnection() {
//        socket.disconnect()
//    }
//    
//}
