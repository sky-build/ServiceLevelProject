//
//  TestViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Alamofire
import RxAlamofire

class TestViewController: BaseViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("RxAlamofire 테스트", for: .normal)
        button.titleLabel?.textColor = .slpWhite
        button.backgroundColor = .slpGreen
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(button.snp.top)
        }
        
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        let url = URL(string: "http://test.monocoding.com:35484/user")!
        let header: HTTPHeaders = [
            "idtoken": "abc"
        ]

        RxAlamofire.requestJSON(.post, url, headers: header)
            .subscribe { (response, error) in
                print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                print(response)
                print("2")
                print(response.statusCode)
                print("3")
                print(error)
                print("4")
                
            } onError: { error in
//                let errorCode = (error as! AFError).responseCode/
//                print(errorCode)
                
                print("에러")
//                print(error.asAFError.errorCode)
                print(error.asAFError?.errorDescription)
                print(error.asAFError?.isResponseValidationError)
            }
            .disposed(by: disposeBag)

//        RxAlamofire.request(.post, url).subscribe { request in
//            print(request)
//        }.disposed(by: disposeBag)
//
//        AF.request(url,
//                   method: .get,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//            .validate(statusCode: 200..<300)
//            .responseJSON { (json) in
    }
    
}
