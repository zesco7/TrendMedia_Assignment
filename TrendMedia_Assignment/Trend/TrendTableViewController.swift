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
        
        self.present(vc, animated: true)
    }
    
    //fullscreen presentation 옵션 추가
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        vc.modalPresentationStyle = .fullScreen //fullscreen presentation
        
        self.present(vc, animated: true)
    }
    
    //navigation controller 연결해서 화면전환: navigation item사용 가능
    @IBAction func boodButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        let navi = UINavigationController(rootViewController: vc) //코드로 vc에 navigation controller 추가
        navi.modalPresentationStyle = .fullScreen //navigation controller에 fullscreen presentation 옵션 추가
        
        self.present(navi, animated: true) //navi를 present하면 연결된 root뷰인 vc가 나옴
    }
    
    
}
