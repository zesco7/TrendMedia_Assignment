//
//  TrendTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/02.
//

import UIKit

/*화면전환 포인트
 -. 1) 화면전환할 스토리보드 파일 2) 스토리보드 파일안에 있는 뷰컨트롤러 중 화면전환할 뷰컨트롤러 3)선택한 화면으로 전환
 -. navigation controller 연결해서 화면전환하면 navigation item 사용 가능
 */

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //영화버튼 클릭하면 BucketListTableViewController present되도록 액션구현(기본스타일은 modal)
    @IBAction func movieButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        //2. TrendTVC -> BucketListTVC 값 전달: 프로퍼티에 데이터추가
        vc.textFieldPlaceholder = "영화이름을 입력해주세요"
        
        
        self.present(vc, animated: true)
    }
    
    //fullscreen presentation 옵션 추가
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        vc.modalPresentationStyle = .fullScreen //fullscreen presentation
        
        //2. TrendTVC -> BucketListTVC 값 전달: 프로퍼티에 데이터추가
        //vc.textFieldPlaceholder = "드라마이름을 입력해주세요"
        vc.textFieldPlaceholder = sender.currentTitle
        
        self.present(vc, animated: true) //뷰컨트롤러를 present했으나 NavigationController를 스토리보드로 구현한 경우라도 naviitem 표시안됨.(스토리보드에 연결되어 있어도 코드로 구현해주어야함)
    }
    
    //navigation controller 연결해서 화면전환: navigation item사용 가능
    @IBAction func boodButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        let navi = UINavigationController(rootViewController: vc) //코드로 vc에 navigation controller 추가
        navi.modalPresentationStyle = .fullScreen //navigation controller에 fullscreen presentation 옵션 추가
        
        //2. TrendTVC -> BucketListTVC 값 전달: 프로퍼티에 데이터추가
        vc.textFieldPlaceholder = "책이름을 입력해주세요"
        
        self.present(navi, animated: true) //navi를 present하면 연결된 root뷰인 vc가 나옴
    }
    
    
}
