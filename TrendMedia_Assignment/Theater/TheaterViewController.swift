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
 -.removeAnnotation메서드에 넣을 매개변수를 어떻게 조건문을 통해 넣을 수 있는지? 배열형태로 하면 어떤내용인지 모르고 순서로만 확인하는 문제 발생 -> 해결: 조건문에 사용될 기준을 매개변수로 처리해서 함수내 함수형태로 생성
 -.액션시트에서 함수 실행시 값이 왜 ()로 찍히는지? : print(self.showSelectedTheater(name: "메가박스"))
 */

/*지도 포인트: 지도에 핀표시를 하기 위해 필요한 기능과 데이터를 나누어서 생각해본다.
 1.우선 핀표시 기능을 가진 함수를 만든다.(setAnnotation) 이 때 원하는 위치마다 핀표시를 하려면 매개변수로 영화관 위치가 필요하다.(이름은 영화관 구분하기 위해 필요)
 2.매개변수를 대입하지 않고 한번에 처리하려면 반복문을 사용해야 한다. 반복문에는 형태, 순서가 구조화 된 데이터가 필요하므로 구조체 형식으로 셋팅한 데이터를 사용한다. 그러므로 구조체데이터를 사용하기 위해서는 인스턴스를 통해 접근해야 하기 때문에 인스턴스를 생성한다.
 3.반복문을 실행하는 함수를 만들고 그 안에 핀표시함수를 넣어주면 반복문을 통해 받은 인자를 핀표시함수에 매개변수로 넣을 수 있다.(showTheaters)
 Q.showSelectedTheater에서 매개변수가 필요한 이유? 선택한 영화관만 표시하려면 조건문으로 분기처리를 해야한다. 이때 매개변수에 따라 원하는대로 기준을 바꿀 수 있도록 매개변수를 사용한다.
 */

/*액션시트 포인트
 -.액션시트 타이틀 없애려면 "" 대신 nil 대입
 -.얼럿은 viewDidLoad에서 실행안되므로 viewDidAppear에서 실행
 -.네비게이션바버튼에서 액션시트 호출할때 별도로 selector용 함수 만들필요 없이 원래 있던 액션시트 함수 사용하면 됨.
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showTheaterList)) //액션시트 실행 위한 바버튼 생성
        
        centerRegion()
        showTheaters()
        
        print(showTheaters())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showTheaterList()
    }
    
    func centerRegion() {
        let center = CLLocationCoordinate2D(latitude: 37.504942, longitude: 126.955041) //중앙대병원 좌표
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(region, animated: true)
    }
    
    func setAnnotation(branch: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = branch
        mapView.addAnnotation(annotation)
    }
    
    //지도에 모든 영화관 핀 표시
    func showTheaters() {
        for i in 0..<theaterInfo.mapAnnotations.count {
            let branch = theaterInfo.mapAnnotations[i].location
            let latitude = theaterInfo.mapAnnotations[i].latitude
            let longitude = theaterInfo.mapAnnotations[i].longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            setAnnotation(branch: branch, coordinate: coordinate)
        }
    }
    
    //지도에 선택한 영화관 핀 표시
    //매개변수가 필요한 이유? 선택한 영화관만 표시하려면 조건문으로 분기처리를 해야하는데 조건문에 매개변수를 추가하여 매개변수에 따라 기준이 바뀌도록 만들어주기 위함
    func showSelectedTheater(name: String) { //전체 어노테이션이 아니라 기준에 맞는 어노테이션만 추가하기 위해 조건문 작성
        for i in 0..<theaterInfo.mapAnnotations.count {
            if name == theaterInfo.mapAnnotations[i].type {
                let location = theaterInfo.mapAnnotations[i].location
                let longitude = theaterInfo.mapAnnotations[i].longitude
                let latitude = theaterInfo.mapAnnotations[i].latitude
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                setAnnotation(branch: location, coordinate: coordinate)
            }
        }
    }
    
    @objc func showTheaterList() {
        let allAnnotations = self.mapView.annotations
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.mapView.removeAnnotations(allAnnotations) //클로저 안에서 함수호출 시 self. 붙여줘야함
            self.showSelectedTheater(name: "메가박스")
            print(self.showSelectedTheater(name: "메가박스"))
        }
        
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.mapView.removeAnnotations(allAnnotations)
            self.showSelectedTheater(name: "롯데시네마")
        }
        
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.mapView.removeAnnotations(allAnnotations)
            self.showSelectedTheater(name: "CGV")
        }
        
        let allTheater = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.showTheaters()
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
