//
//  ChatViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/04/04.
//

import Foundation
import RxRelay

enum ChatState {
    case my
    case other
}

struct ChatData {
    let state: ChatState
    let chat: String
}

class ChatViewModel {
    
    static let shared = ChatViewModel()
    private init() { }
    
    let chatData = BehaviorRelay<[ChatData]>(value: [])
}
