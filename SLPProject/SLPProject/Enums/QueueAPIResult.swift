//
//  QueueAPIResult.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import Foundation

enum QueueAPIResult: String {
    case noConnectinon = "네트워크에 연결할 수 없습니다."   // enum 처리
    case success = "성공"
    // 상태 추가하기
    case stopQueue = "찾기 중단"
    case refreshData = "새로고침"
    case requestUserSuccess = "친구요청 성공"
    
    case alreadyMatch = "누군가와 취미를 함께하기로 약속하셨어요!"
    case friendsDeleteMe = "상대방이 취미찾기를 그만두었습니다."
    
    case friendAlreadyMatchingOtherUser = "상대방이 이미 다른 사람과 취미를 함께하는 중입니다"
    case friendsCancelMe = "상대방이 취미 함께 하기를 그만두었습니다"
    case anyPersonAcceptMyRequest = "앗! 누군가가 나의 취미 함께 하기를 수락하였어요!"
    
    
    case moreThreeReportUser = "신고가 누적되어 이용하실 수 없습니다."
    case penaltyGradeOne = "약속 취소 패널티로, 1분동안 이용하실 수 없습니다"
    case penaltyGradeTwo = "약속 취소 패널티로, 2분동안 이용하실 수 없습니다"
    case penaltyGradeThree = "연속으로 약속을 취소하셔서 3분동안 이용하실 수 없습니다"
    case noGenderSelect = "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!"
    case firebaseTokenError = "토큰 에러"
    case noRegisterUser = "미가입 회원"
    case serverError = "server error"
    case clientError = "client error"
}
