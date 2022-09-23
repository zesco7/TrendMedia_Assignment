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
 -.영화관 구조체 데이터에 어떻게 접근하도록 만드는지? 일일이 함수 작성하는 방식은 당연히 아닐 것 같은데 구조체에서 값을 접근하지 못하겠음
 -.개별적으로 함수만든다고 쳐도 removeAnnotation 매개변수가 MKAnnotation타입인데 MKAnnotation을 넣을수가 없음
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
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centerRegion()
        
        setRegionAndAnnotation()
        setRegionAndAnnotation2()
        setRegionAndAnnotation3()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showTheaterList()
        
    }
    
    func centerRegion() {
        let center = CLLocationCoordinate2D(latitude: 37.504942, longitude: 126.955041) //중앙대병원 좌표
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(region, animated: true)
    }
    
    func setRegionAndAnnotation() {
        
        for data in
        let annotation = MKPointAnnotation()
        let center = CLLocationCoordinate2D(latitude: latitude[0], longitude: longitude[0])
        annotation.coordinate = center
        annotation.title = location[0]
        mapView.addAnnotation(annotation)
    }
    
    func setRegionAndAnnotation2() {
        let location = theaterInfo.mapAnnotations.filter { $0.type == "메가박스" }.map { $0.location }
        let latitude = theaterInfo.mapAnnotations.filter { $0.type == "메가박스" }.map { $0.latitude }
        let longitude = theaterInfo.mapAnnotations.filter { $0.type == "메가박스" }.map { $0.longitude }

        let annotation = MKPointAnnotation()
        let center = CLLocationCoordinate2D(latitude: latitude[1], longitude: longitude[1])
        

        annotation.coordinate = center
        annotation.title = location[1]
        mapView.addAnnotation(annotation)
    }
    
    func setRegionAndAnnotation3() {
        let location = theaterInfo.mapAnnotations.filter { $0.type == "CGV" }.map { $0.location }
        let latitude = theaterInfo.mapAnnotations.filter { $0.type == "CGV" }.map { $0.latitude }
        let longitude = theaterInfo.mapAnnotations.filter { $0.type == "CGV" }.map { $0.longitude }

        let annotation = MKPointAnnotation()
        let center = CLLocationCoordinate2D(latitude: latitude[0], longitude: longitude[0])

        annotation.coordinate = center
        annotation.title = location[0]
        mapView.addAnnotation(annotation)
    }
    
    func showTheaterList() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            //mapView.removeAnnotation()
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            //mapView.removeAnnotation()
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            //mapView.removeAnnotation()
        }
        let allTheater = UIAlertAction(title: "전체보기", style: .default) { _ in
            
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
