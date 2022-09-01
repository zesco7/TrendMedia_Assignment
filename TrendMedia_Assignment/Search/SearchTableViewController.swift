//
//  SearchTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

/*질문
 -. 해리포터 영화정보 어디서 받아오는지? -> 영화정보 받아오면 다시 제출하겠습니다.
 -. tableViewCell 레이아웃 제대로 잡은 것 같고 스토리보드상에서는 적용다되어있는데 시뮬레이터에서 다깨지는 이유가 뭔지?(사진은 배율이 안맞고, 글자는 전부다 겹치고 있음)
 */

class SearchTableViewController: UITableViewController {
    
    //var moviePosterList = ["star.fill", "star", "star.fill", "star"]
    var movieTitleList = ["해리포터1", "해리포터2", "해리포터3", "해리포터4"]
    var movieOpeningDayList = ["2022-01-01", "2022-02-01", "2022-03-01", "2022-04-01"]
    var movieStoryList = ["1111", "2222", "3333", "4444"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 320

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieTitleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        //cell.moviePoster.image = moviePosterList[indexPath.row]
        cell.moviePoster.image = UIImage(named: "극한직업")
        cell.movieTitle.text = movieTitleList[indexPath.row]
        cell.movieOpeningDay.text = movieOpeningDayList[indexPath.row]
        cell.movieStory.text = movieStoryList[indexPath.row]
        
        return cell
    }

    }
