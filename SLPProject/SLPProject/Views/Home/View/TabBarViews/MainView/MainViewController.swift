//
//  MainViewController.swift
//  SLPProject
//
//  Created by 노건호 on 2022/01/27.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
import RxSwift

class MainViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainView()
    
    var disposeBag = DisposeBag()
    
    var locationManager: CLLocationManager = CLLocationManager() // location manager
    var currentLocation: CLLocation!
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.model.filterState
            .subscribe(onNext: { [self] value in
                mainView.mapView.markFriendsAnnotation(viewModel.model.nearFriends.value, filter: viewModel.model.filterState.value)
            })
            .disposed(by: disposeBag)
        
        viewModel.model.currentPosition
            .subscribe(onNext: { [self] data in
                viewModel.queueAPI.onQueue()
            })
            .disposed(by: disposeBag)
        
        viewModel.queueAPI.state
            .subscribe { [self] _ in
                print(viewModel.model.fromRecomend.value)
                print(viewModel.model.requestNearFriends.value)
                print(viewModel.model.nearFriends.value)
                mainView.mapView.markFriendsAnnotation(viewModel.model.nearFriends.value, filter: viewModel.model.filterState.value)
            }
            .disposed(by: disposeBag)


        
        // 위치정보가 활성화되어있다면
        if CLLocationManager.locationServicesEnabled() {
            // 위치정보 받아오기 시작
            locationManager.startUpdatingLocation()
        }
        
        // mapView 설정
        setMapView()
        
        // filterButton 설정
        setFilterButtons()
        
        // statusButton 설정
        setStatusButton()
        
        // gps버튼 설정
        setGPSButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // mapView 설정
    func setMapView() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mainView.mapView.delegate = self
        // 회전 못하게 설정
        mainView.mapView.isRotateEnabled = false
        
        mainView.mapView.register(MainManAnnotationView.self, forAnnotationViewWithReuseIdentifier: MainManAnnotationView.identifier)
        mainView.mapView.register(MainWomanAnnotationView.self, forAnnotationViewWithReuseIdentifier: MainWomanAnnotationView.identifier)
        mainView.mapView.register(MainMyAnnotationView.self, forAnnotationViewWithReuseIdentifier: MainMyAnnotationView.identifier)
    }
    
    // filterButton 설정
    private func setFilterButtons() {
        mainView.filterButton.allButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.manButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.womanButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func filterButtonClicked(_ sender: UIButton) {
        let senderButton = MainViewFilterState(rawValue: sender.currentTitle!)!
        mainView.filterButton.selectButton = senderButton
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        mainView.mapView.markAnnotation(mainView.mapView.centerCoordinate, region: false)
        viewModel.model.filterState.accept(senderButton)
    }
    
    // statusButton 설정
    private func setStatusButton() {
        mainView.mainStatusButton.addTarget(self, action: #selector(statusButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func statusButtonClicked(_ sender: UIButton) {
        let vc = MainSearchViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // gps버튼 설정
    private func setGPSButton() {
        mainView.placeButton.addTarget(self, action: #selector(gpsButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func gpsButtonClicked(_ sender: UIButton) {
        if let coordinate = locationManager.location?.coordinate {
            mainView.mapView.removeAnnotations(mainView.mapView.annotations)
            mainView.mapView.markAnnotation(coordinate)
            viewModel.model.currentPosition.accept([coordinate.latitude, coordinate.longitude])
        } else {
            view.makeToast("네트워크 연결이 원활하지 않습니다.")
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let position = mapView.centerCoordinate
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        mapView.markAnnotation(mapView.centerCoordinate, region: false)
        viewModel.model.currentPosition.accept([position.latitude, position.longitude])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title == "my" {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MainMyAnnotationView.identifier) as! MainMyAnnotationView
            return annotationView
        } else if annotation.title == "여자" {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MainManAnnotationView.identifier) as! MainManAnnotationView
            return annotationView
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MainWomanAnnotationView.identifier) as! MainWomanAnnotationView
            return annotationView
        }
    }
    
}

extension MainViewController: CLLocationManagerDelegate {
    
    // 위치가 업데이트 될 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            mainView.mapView.removeAnnotations(mainView.mapView.annotations)
            mainView.mapView.markAnnotation(coordinate)
            viewModel.model.currentPosition.accept([coordinate.latitude, coordinate.longitude])
        }
    }
    
}
