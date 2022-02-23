//
//  ChatSocket.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/22.
//

import Foundation
import SocketIO

class ChatSocket: NSObject {
    
//    static let shared = ChatSocket()
//    private init() {}
    
    var manager: SocketManager!
    var socket: SocketIOClient!

    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:35484/")!
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["idtoken" : FirebaseToken.shared.idToken])
        ])
        
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("socket is connected", data, ack)
            self.socket.emit("changesocketid", "2P5l9BKOVcQPnpWS15OL0wHhyi13")
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket is disconnected", data, ack)
        }
    }
    
    func establishConnection() {
        print("연결시도")
        socket.connect()
        
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
