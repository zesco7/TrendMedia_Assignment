
/*
 TheaterList
 */

struct Theater {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}

struct TheaterList {
    var mapAnnotations: [Theater] = [
        Theater(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}

/*
 Location Authorization Custom Alert


func showRequestLocationServiceAlert() {
  let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
  let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
    
  }
  let cancel = UIAlertAction(title: "취소", style: .default)
  requestLocationServiceAlert.addAction(cancel)
  requestLocationServiceAlert.addAction(goSetting)
  
  present(requestLocationServiceAlert, animated: true, completion: nil)
}
*/
