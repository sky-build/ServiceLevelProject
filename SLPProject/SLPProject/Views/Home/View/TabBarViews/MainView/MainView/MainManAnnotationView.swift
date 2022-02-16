//
//  MainManAnnotationView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/11.
//

import MapKit

enum GenderState: String {
    case face1 = "sesac_face_1"
    case face2 = "sesac_face_2"
    case face3 = "sesac_face_3"
    case face4 = "sesac_face_4"
    case face5 = "sesac_face_5"
}

final class MainManAnnotationView: MKAnnotationView {
    
    static let identifier = "MainManAnnotationView"
    
    var genderState: GenderState = .face1 {
        didSet {
            self.image = UIImage(named: genderState.rawValue)
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.image = UIImage(named: "sesac_face_4")
        self.frame.size = CGSize(width: 83, height: 83)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
