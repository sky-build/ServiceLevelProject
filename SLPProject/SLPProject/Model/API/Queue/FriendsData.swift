//
//  FriendsData.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/08.
//

import Foundation

// MARK: - FriendsData
struct FriendsData: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}
