//
//  MainView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/07.
//

import UIKit
import MapKit
import SnapKit

class MainView: UIView, FetchViews {
    
    // 전체, 남자, 여자 버튼
    let filterButton = MainFilterButtons()
    
    let placeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "place"), for: .normal)
        button.backgroundColor = .slpWhite
        button.layer.cornerRadius = 8
        return button
    }()
    
    let mainStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "default"), for: .normal)
        return button
    }()
    
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        [mapView, filterButton, placeButton, mainStatusButton].forEach {
            self.addSubview($0)
        }
    }
    
    func makeConstraints() {
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(super.safeAreaLayoutGuide)
        }
        
        filterButton.snp.makeConstraints {
            $0.top.leading.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(48)
            $0.height.equalTo(48 * 3)
        }
        
        placeButton.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(16)
            $0.width.height.equalTo(48)
            $0.centerX.equalTo(filterButton)
        }
        
        mainStatusButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(super.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(64)
        }
    }
}
