//
//  HomeViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/08.
//

import RxRelay

class MainModel {
    
    static let shared = MainModel()
    
    // 근처친구
    let nearFriends = BehaviorRelay<[FromQueueDB]>(value: [])
    
    let requestNearFriends = BehaviorRelay<[FromQueueDB]>(value: [])
    
    let fromRecomend = BehaviorRelay<[String]>(value: [])
    
    let currentPosition = BehaviorRelay<[Double]>(value: [37.482733667903865, 126.92983890550006])
    
    let filterState = BehaviorRelay<MainViewFilterState>(value: .all)
    
    private init() { }
    
}
