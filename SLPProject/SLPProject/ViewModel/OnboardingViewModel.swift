//
//  OnboardingViewModel.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/23.
//

import UIKit

class OnboardingViewModel {
    
    let attributedTitles: [NSMutableAttributedString] =  {
        let title = ["위치 기반으로 빠르게\n주위 친구를 확인", "관심사가 같은 친구를\n찾을 수 있어요", "SeSAC Frineds"]
        
        var titles: [NSMutableAttributedString] = []
        
        title.forEach { string in
            let attributedStr = NSMutableAttributedString(string: string)
            
            attributedStr.addAttribute(.foregroundColor, value: UIColor.slpGreen, range: (string as NSString).range(of: "위치 기반"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.slpGreen, range: (string as NSString).range(of: "관심사가 같은 친구"))
            
            titles.append(attributedStr)
        }
        
        return titles
    }()
}
