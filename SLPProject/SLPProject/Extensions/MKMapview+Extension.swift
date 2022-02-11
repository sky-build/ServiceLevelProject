//
//  MapView+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/09.
//

import MapKit

extension MKMapView {
    
    // 내위치 annotation
    func markAnnotation(_ coordinate: CLLocationCoordinate2D, region: Bool = true) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "my"
        self.addAnnotation(annotation)
        
        // 위치 설정
        if region {
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.setRegion(region, animated: true)
            
        }
    }
    
    // 친구 annotation
    func markFriendsAnnotation(_ friendsData: [FromQueueDB], filter: MainViewFilterState = .all) {
        
        friendsData.forEach {
            let userGender = GenderType(rawValue: $0.gender)!
            
            if filter == .all || (filter == .man && userGender == .man) || (filter == .woman && userGender == .woman) {
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
                annotation.title = userGender == .woman ? "여자" : "남자"
                annotation.coordinate = coordinate
                
                self.addAnnotation(annotation)
            }
        }
    }

}
