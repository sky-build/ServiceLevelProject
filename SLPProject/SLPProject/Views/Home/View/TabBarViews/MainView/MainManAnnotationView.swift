//
//  MainManAnnotationView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/11.
//

import MapKit

final class MainManAnnotationView: MKAnnotationView {
    
    static let identifier = "MainManAnnotationView"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.image = UIImage(named: "sesac_face_4")
        self.frame.size = CGSize(width: 83, height: 83)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
