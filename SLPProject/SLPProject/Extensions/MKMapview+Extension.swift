//
//  MapView+Extension.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/09.
//

import MapKit

extension MKMapView {
    
    func markAnnotation(_ coordinate: CLLocationCoordinate2D) {
        self.removeAnnotations(self.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.addAnnotation(annotation)
        
        // 위치 설정
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.setRegion(region, animated: true)
    }
    
}
