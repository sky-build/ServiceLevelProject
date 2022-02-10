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

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    var locationManager: CLLocationManager = CLLocationManager() // location manager
    var currentLocation: CLLocation!
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mainView.mapView.delegate = self
        // 회전 못하게 설정
        mainView.mapView.isRotateEnabled = false
        
        // 위치정보가 활성화되어있다면
        if CLLocationManager.locationServicesEnabled() {
            // 위치정보 받아오기 시작
            locationManager.startUpdatingLocation()
        }
        
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
    
    // filterButton 설정
    private func setFilterButtons() {
        mainView.filterButton.allButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.manButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
        mainView.filterButton.womanButton.addTarget(self, action: #selector(filterButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func filterButtonClicked(_ sender: UIButton) {
        let senderButton = MainViewFilterState(rawValue: sender.currentTitle!)!
        mainView.filterButton.selectButton = senderButton
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
            mainView.mapView.markAnnotation(coordinate)
        } else {
            view.makeToast("네트워크 연결이 원활하지 않습니다.")
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.markAnnotation(mapView.centerCoordinate, region: false)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    // 위치가 업데이트 될 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            mainView.mapView.markAnnotation(coordinate)
        }
    }
    
}
