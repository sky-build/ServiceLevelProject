//
//  MainMyAnnotationView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/11.
//

import MapKit

final class MainMyAnnotationView: MKAnnotationView {
    
    static let identifier = "MainMyAnnotationView"


    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.image = UIImage(named: "map_marker")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
