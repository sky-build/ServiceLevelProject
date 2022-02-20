//
//  ChatData.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/19.
//

import Foundation

// MARK: - Chat
struct Chat: Codable {
    let payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let id: String
    let v: Int
    let to, from, chat, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case to, from, chat, createdAt
    }
}
