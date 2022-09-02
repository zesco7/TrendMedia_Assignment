//
//  SearchTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

/*질문
 -. 해리포터 영화정보 어디서 받아오는지? -> 해결
 -. tableViewCell 레이아웃 제대로 잡은 것 같고 스토리보드상에서는 적용다되어있는데 시뮬레이터에서 다깨지는 이유가 뭔지?(사진은 배율이 안맞고, 글자는 전부다 겹치고 있음) -> 해결: 스토리보드 뷰컨트롤러 삭제하고 다시 만듦
 */

class SearchTableViewController: UITableViewController {
    //MovieInfo는 초기화 해야하는 프로퍼티가 없기 때문에 매개변수가 없다.(MovieInfo파일에 값이 이미 초기화되어 있음)
    var movieList = MovieInfo()
    var movieTitleList = ["해리포터1", "해리포터2", "해리포터3", "해리포터4", "해리포터5", "해리포터6", "해리포터7", "해리포터8"]
    var movieOpeningDayList = ["2022-01-01", "2022-02-01", "2022-03-01", "2022-04-01", "2022-05-01", "2022-06-01", "2022-07-01", "2022-08-01"]
    var movieStoryList = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MovieInfo Struct에 Movie배열을 가지고 있기 때문에 배열count사용 가능(구조체이름이나 배열이름이 아니라 대입된 변수로 접근)
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        //cell을 재사용할 때마다 configureCell을 호출하여 cell마다 함수에 정해진 속성을 이용한다.
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    //화면크기를 기준으로 row 높이 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    
    /*didSelectRowAt가 동작하지 않는 경우
     1. tableView에서 selection옵션이 noselection으로 설정되어 있어서 선택이 안됨
     2. 셀 위에 전체버튼 있어서 셀을 누르는게 아니라 실제로는 버튼을 누르는 상태
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RecommendationCollectionViewController.identifier) as! RecommendationCollectionViewController
        
        self.navigationController?.pushViewController(vc, animated: true) //vc에 navigationController연결을 해주어야 화면이 push된다.(안되어 있으면 optional조건에 의해 push안됨.)
    }
    
    
}
