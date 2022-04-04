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
//        socket = self.manager.socket(forNamespace: "/")

        socket.on("test") { (dataArray, ack) in
            print("데이터 도착")
            print(dataArray)
            print(dataArray[0])
            let data: String = dataArray[0] as! String
            print(data)
            var array: [ChatData] = ChatViewModel.shared.chatData.value
            if array.last?.chat != data {
                array.append(ChatData(state: .other, chat: data))
                ChatViewModel.shared.chatData.accept(array)
            }
        }
    }

    func establishConnection() {
        socket.connect()
        print("연결", socket.status)
    }

    func sendClosure(completion: @escaping () -> Void) {
        socket.connect()

        completion()
    }

    func closeConnection() {
        socket.disconnect()
    }

    func sendMessage() {
        sendClosure {
            self.socket.emit("event", ["message" : "This is a test message"])
            self.socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
            self.socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
        }
    }

    func sendMessage(message: String, nickname: String) {
//        socket.emit("event", ["message" : "This is a test message"])
        socket.emit("test", message)
//        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
//        socket.emit("msg", ["nick": nickname, "msg" : message])
//        socket.emit("msg", ["nick": nickname, "msg" : message])
//        print("abc")
    }

}
