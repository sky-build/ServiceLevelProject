//
//  MainFriendsAnnotationView.swift
//  SLPProject
//
//  Created by 노건호 on 2022/02/11.
//

import MapKit

enum ImageState: String {
    case one = "sesac_face_1"
    case two = "sesac_face_2"
    case three = "sesac_face_3"
    case fout = "sesac_face_4"
    case five = "sesac_face_5"
    
    func getImage() -> UIImage {
        return UIImage(named: self.rawValue)!
    }
}

final class MainFriendsAnnotationView: MKAnnotationView {
    
    static let identifier = "MainFriendsAnnotationView"
    
    var imageState: ImageState? {
        didSet {
            self.image = imageState?.getImage()
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
