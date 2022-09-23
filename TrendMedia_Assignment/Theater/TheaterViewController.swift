//
//  TheaterViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/23.
//

import UIKit
import CoreLocation
import MapKit



/*질문
 -.영화관 구조체 데이터에 어떻게 접근하도록 만드는지? 일일이 함수 작성하는 방식은 당연히 아닐 것 같은데 구조체에서 값을 접근하지 못하겠음 -> 해결: 어떤 매개변수가 필요한지 확인하여 함수를 만들고 매개변수를 반복문으로 처리할 수 있는 함수를 하나더 만들어 처리(함수 내 함수 형태)
 -.removeAnnotation메서드에 넣을 매개변수를 어떻게 조건문을 통해 넣을 수 있는지? 배열형태로 하면 어떤내용인지 모르고 순서로만 확인하는 문제 발생
 */

/*지도 포인트
 -.
 
 */

/*액션시트 포인트
 -.액션시트 타이틀 없애려면 "" 대신 nil 대입
 -.얼럿은 viewDidLoad에서 실행안되므로 viewDidAppear에서 실행
 */

class TheaterViewController: UIViewController {
    static var identifier = "TheaterViewController"
    
    let locationManager = CLLocationManager()
    let theaterInfo = TheaterList()
    
    var theaterType = Array<String>()
    var theaterName = Array<String>()
    var theaterCoordinate = Array<CLLocationCoordinate2D>()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        centerRegion()
        showTheaters()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showTheaterList()
    }
    
    func centerRegion() {
        let center = CLLocationCoordinate2D(latitude: 37.504942, longitude: 126.955041) //중앙대병원 좌표
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(region, animated: true)
    }
    
    func showTheaters() {
        for i in 0..<theaterInfo.mapAnnotations.count {
            let branch = theaterInfo.mapAnnotations[i].location
            let latitude = theaterInfo.mapAnnotations[i].latitude
            let longitude = theaterInfo.mapAnnotations[i].longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            setAnnotation(branch: branch, coordinate: coordinate)
        }
    }
    
    func setAnnotation(branch: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = branch
        mapView.addAnnotation(annotation)
    }
    
    //잘못된 접근방식
    func setRegionAndAnnotation(name: String, location: CLLocationCoordinate2D) {
        for i in 0..<theaterInfo.mapAnnotations.count {
            let type = theaterInfo.mapAnnotations[i].type
            let loacation = theaterInfo.mapAnnotations[i].location
            let longitude = theaterInfo.mapAnnotations[i].longitude
            let latitude = theaterInfo.mapAnnotations[i].latitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            self.theaterType.append(type)
            self.theaterName.append(loacation)
            self.theaterCoordinate.append(coordinate)
        }
        print(theaterType)
        print(theaterName)
        print(theaterCoordinate)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
    
    func showTheaterList() {
        let allAnnotations = self.mapView.annotations
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            //mapView.removeAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            //mapView.removeAnnotation()
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            //mapView.removeAnnotation()
        }
        let allTheater = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.mapView.removeAnnotation(allAnnotations[0])
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(megabox)
        actionSheet.addAction(lotte)
        actionSheet.addAction(cgv)
        actionSheet.addAction(allTheater)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true)
    }
}
