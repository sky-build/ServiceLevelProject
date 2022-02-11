//
//  File.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/11.
//

import MapKit

final class MainWomanAnnotationView: MKAnnotationView {
    
    static let identifier = "MainWomanAnnotationView"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.image = UIImage(named: "sesac_face_5")
        self.frame.size = CGSize(width: 83, height: 83)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
