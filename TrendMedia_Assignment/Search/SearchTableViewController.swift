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
    
    
    var movieTitleList = ["해리포터1", "해리포터2", "해리포터3", "해리포터4", "해리포터5", "해리포터6", "해리포터7", "해리포터8"]
    var movieOpeningDayList = ["2022-01-01", "2022-02-01", "2022-03-01", "2022-04-01", "2022-05-01", "2022-06-01", "2022-07-01", "2022-08-01"]
    var movieStoryList = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieTitleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        //cell.moviePoster.image = moviePosterList[indexPath.row]
        cell.moviePosterImageView.image = UIImage(named: "극한직업")
        cell.movieTitleLabel.text = movieTitleList[indexPath.row]
        cell.movieOpeningDayLabel.text = movieOpeningDayList[indexPath.row]
        cell.movieStoryLabel.text = movieStoryList[indexPath.row]
        
        return cell
    }
    
    //화면크기를 기준으로 row 높이 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    

    }
