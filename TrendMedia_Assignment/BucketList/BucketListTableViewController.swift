//
//  BucketListTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    
    @IBOutlet weak var userTextField: UITextField!
    
    var list = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.append("마녀")
        list.append("헤어질 결심")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexPath매개변수는 없어도 되지만 있으면 인덱스를 사용해서 셀마다 다른 값을 줄 수 있음.
        //tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath): 화면에서 셀 가져옴
        //as! BucketListTableViewCell: 가져온 셀을 클래스파일에 연결.
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 20)
        
        return cell
    }
    
    //row수정 함수: 추가 구현해야 작동함
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    //row삭제 함수: right to left로 swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row) //해당 index의 row 삭제
            tableView.reloadData()
        }
    }
    
    //즐겨찾기 핀고정 기능
    //override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //}
    
    
    /*텍스트필드 값 tableViewCell추가 함수
     -. 배열에 데이터를 추가하고 reloadData 사용하여 테이블뷰를 갱신해주어야 화면에 추가된 배열이 보인다.
     -. 특정 section, row에만 따로 적용할 수도 있다. reloadSections, reloadRows
     */
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        list.append(sender.text!) //sender인 텍스트필드값을 list배열에 추가
        
        tableView.reloadData() //테이블뷰 갱신
        //tableView.reloadSections(IndexSet, with: <#T##UITableView.RowAnimation#>)
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
        print(list)
    }
}
