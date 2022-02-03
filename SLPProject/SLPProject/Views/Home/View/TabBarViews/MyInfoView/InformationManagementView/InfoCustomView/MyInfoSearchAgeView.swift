//
//  MyInfoSearchAgeView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/03.
//

import UIKit
import SnapKit
import MultiSlider

class MyInfoSearchAgeView: UIView, FetchViews {
    
    var averageAge = [18, 65] {
        didSet {
            changeAgeLabel()
        }
    }
    
    let searchAgeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = .Title4_R14
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textColor = .slpGreen
        return label
    }()
    
    let ageSlider: MultiSlider = {
        let slider = MultiSlider()
        slider.orientation = .horizontal
        
        slider.minimumValue = 18.1    // default is 0.0
        slider.maximumValue = 65.1    // default is 1.0

        // 슬라이더간 최소 너비를 정해주는 코드(이부분 팀빌딩 해보기)
        slider.distanceBetweenThumbs = 0
        
        // 슬라이더가 있는 위치
        slider.value = [18.1, 65.1]
        
        slider.disabledThumbIndices = [20, 40]
        
        slider.outerTrackColor = .slpGray2
        slider.tintColor = .slpGreen
        slider.trackWidth = 4
        
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged) // continuous changes
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
        
        changeAgeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [searchAgeTitleLabel, ageSlider, ageLabel].forEach {
            addSubview($0)
        }
    }
    
    func makeConstraints() {
        searchAgeTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        ageLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        ageSlider.snp.makeConstraints {
            $0.top.equalTo(searchAgeTitleLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(38)
            $0.bottom.equalToSuperview()
        }
    }
    
    // 슬라이더 값 변경되었을 때
    @objc func sliderChanged(_ sender: MultiSlider) {
        averageAge = sender.value.map { Int($0) }
    }
    
    // 변경된 값 라벨에 반영
    private func changeAgeLabel() {
        ageLabel.text = "\(averageAge[0]) - \(averageAge[1])"
    }
}
