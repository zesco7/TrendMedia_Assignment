//
//  TheaterViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/22.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let coornidateYDPcampus = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270) //취업사관학교 좌표
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "지도 중심입니다."
        mapView.addAnnotation(annotation)
    }
}

//1. iOS버젼 확인 + 위치서비스 활성화 여부체크 + 위치권한 상태 확인 + 위치권한 거부시 얼럿
extension TheaterViewController {
    //iOS버젼 확인 + 위치서비스 활성화 여부체크
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) { //iOS버젼 확인
            authorizationStatus = locationManager.authorizationStatus //현재 위치서비스 활성화 상태
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() { //위치서비스 활성화 여부체크
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 권한 요청을 못합니다.")
        }
    }
    
    //위치권한 상태 확인
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //얼럿 띄우기
        case .restricted, .denied:
            print("DENIED")
            setRegionAndAnnotation(center: coornidateYDPcampus) //권한 거부시 취업사관학교 위치 업데이트
            showRequestLocationServiceAlert() //설정가서 허용유도
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation() //권한허용시 사용자 위치 업데이트
        default: print("DEFAULT")
        }
    }
    
    //위치권한 거부시 얼럿
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) { //"설정으로 이동"눌렀을 때 디바이스 설정메뉴로 이동하도록 액션 추가
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

//2. 위치권한 관련 프로토콜
extension TheaterViewController: CLLocationManagerDelegate {
    //위치권한허용(사용자 위치 데이터 수신 성공한 경우)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate) //위치권한 허용해서 받은 좌표정보 사용하여 지도중심 표시
        }
        locationManager.stopUpdatingLocation() //불필요한 위치정보 반복요청 중단
    }
    
    //위치권한 미허용(사용자 위치 데이터 수신 실패한 경우)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //위치권한 변경시
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { //iOS14+
        checkUserDeviceLocationServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
