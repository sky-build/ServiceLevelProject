//
//  MapView+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/09.
//

import MapKit

extension MKMapView {
    
    func markAnnotation(_ coordinate: CLLocationCoordinate2D, region: Bool = true) {
        self.removeAnnotations(self.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.addAnnotation(annotation)
        
        // 위치 설정
        if region {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.setRegion(region, animated: true)
            
        }
    }
    
//    private func calculateRegion() -> String {
//        self.
//    }

}
