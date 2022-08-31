//
//  SettingTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit

/*질문
 -. tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)에서 indexPath parameter의 의미가 무엇인지 모르겠음.
 예) 한 뷰컨트롤러 안에 firstTableView, secondTableView 뷰 두 개가 있는 상황.
 ->해당 뷰컨트롤러의 viewDidLoad에서 tableView함수를 호출하고 첫번째 parameter에 firstTableView를 넣는 건 firstTableView에 tableView함수를 적용한다는 의미인데, 그럼 두번째 parameter는 왜 필요한건지? 어떤 cell에는 속성을 적용할지 말지 정하지 위해서인지?
 */

class SettingTableViewController: UITableViewController {
    
    var birthdayFriends = ["도라에몽", "진구", "이슬이", "징징이", "퉁퉁이", "진구엄마"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //section 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    //header 추가: 조건문을 통해 section마다 header 내용을 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "생일인 친구"
        } else if section == 1{
            return "즐겨찾기"
        } else if section == 2{
            return "카카오톡친구"
        } else {
            return "섹션"
        }
    }
    
    //row 갯수: 조건문을 통해 section마다 row 갯수를 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //row number를 arraycount와 짝을 맞춰주면 나중에 배열이 추가, 삭제되어도 자동으로 갯수 맞춰짐.
            return birthdayFriends.count
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 3
        } else {
            return 10
        }
    }
    
    //cell contents 설정: 조건문을 통해 row마다 cell contents를 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell")!
        
        if indexPath.section == 0 {
            //row number와 array index 위치를 맞춰놓으면 배열값을 일일이 대입하지 않아도 indexPath.row로 표시할 수 있다.
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .red
            cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        } else if indexPath.section == 1 {
            cell.textLabel?.textColor = .green
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        } else if indexPath.section == 2 {
            cell.textLabel?.textColor = .blue
            cell.textLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        } else {
            cell.textLabel?.text = "잘못된 값입니다."
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = .systemFont(ofSize: 5, weight: .bold)
        }
        
        //return cell을 쓰는 이유? -> 속성 적용을 해주었으므로 속성이 적용된 변수를 반환해야 하기 때문이다.
        return cell
    }
}
