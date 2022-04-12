//
//  SocketIOManager.swift
//  SLPProject
//
//  Created by 노건호 on 2022/04/04.
//

import UIKit
import SocketIO

//class SocketIOManager:NSObject{
//    static let shared = SocketIOManager()
//
//    override init() {
//        super.init()
//        socket = self.manager.socket(forNamespace: "/")
//    }
//
//    var manager = SocketManager(socketURL: URL(string: "http://192.168.0.4:3000")!, config: [.log(true), .compress])
//    var socket : SocketIOClient!
//
//    func establishConnection(){
//        socket.connect()
//    }
//
//    func closeConnection(){
//        socket.disconnect()
//    }
//}

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()

    var manager = SocketManager(socketURL: URL(string: "http://localhost:3000/")!, config: [
        .log(true),
        .compress
    ])
    var socket: SocketIOClient!

    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/test")

        socket.on("test") { (dataArray, ack) in
            let data: String = dataArray[0] as! String

            var array: [ChatData] = ChatViewModel.shared.chatData.value
            if array.last?.chat != data {
                array.append(ChatData(state: .other, chat: data))
                ChatViewModel.shared.chatData.accept(array)
            }
        }
    }

    func establishConnection() {
        socket.connect()
    }

    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String, nickname: String) {
        socket.emit("test", message)
    }

}
