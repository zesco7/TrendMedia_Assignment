//
//  SettingTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit
/*질문: Case1
 -. cell색상 적용하는 방법?
 -. 헤더 글자가 너무 안보이는데, 헤더 글자색 변경하는 방법?
 */


/*질문: Case2
 -. tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)에서 indexPath parameter의 의미가 무엇인지 모르겠음.
 예) 한 뷰컨트롤러 안에 firstTableView, secondTableView 뷰 두 개가 있는 상황.
 ->해당 뷰컨트롤러의 viewDidLoad에서 tableView함수를 호출하고 첫번째 parameter에 firstTableView를 넣는 건 firstTableView에 tableView함수를 적용한다는 의미인데, 그럼 두번째 parameter는 왜 필요한건지? 어떤 cell에는 속성을 적용할지 말지 정하지 위해서인지?
 
 -. 섹션별 헤더 배열적용을 indexPath.row사용해서 코드 줄일 수 있는지?
 -. 빌드하면 헤더와 로우 들여쓰기가 다른 이유?
 */


//CaseIterable: 열거형을 프로토콜이나 배열처럼 사용할 수 있는 특성
enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    
    var sectionTitle: String {
        switch self {
    case .total:
        return "전체 설정"
    case .personal:
        return "개인 설정"
    case .others:
        return "기타"
        }
    }
    
    var rowTitle: [String] {
        switch self {
    case .total:
        return ["공지사항", "실험실", "버전 정보"]
    case .personal:
        return ["개인/보안", "알림", "채팅", "멀티프로필"]
    case .others:
        return ["고객센터/도움말"]
        }
    }
}



class SettingTableViewController: UITableViewController {
    
    var headerArray = ["전체 설정", "개인 설정", "기타"]
    var generalSettingArray = ["공지사항", "실험실", "버전 정보"]
    var privateSettingArray = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var othersSettingArray = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        tableView.rowHeight = 80
    }
    
    //section 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return 3
        return SettingOptions.allCases.count //SettingOptions열거형에 있는 멤버 갯수를 배열길이처럼 사용한다.
    }
    
    //header 추가: 조건문을 통해 section마다 header 내용을 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return headerArray[0]
        } else if section == 1{
            return headerArray[1]
        } else if section == 2{
            return headerArray[2]
        } else {
            return "에러"
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .systemGray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
    }
    
    //row 갯수: 조건문을 통해 section마다 row 갯수를 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            //row number를 arraycount와 짝을 맞춰주면 나중에 배열이 추가, 삭제되어도 자동으로 갯수 맞춰짐.
            return generalSettingArray.count
        } else if section == 1 {
            return privateSettingArray.count
        } else if section == 2 {
            return othersSettingArray.count
        } else {
            return 0
        }
        
        //
        if section == 0 {
            return SettingOptions.allCases[0].rowTitle.count
        } else if section == 1 {
            return SettingOptions.allCases[1].rowTitle.count
        } else if section == 2 {
            return SettingOptions.allCases[2].rowTitle.count
        } else {
            return 1
        }
        
        return SettingOptions.allCases[section].rowTitle.count
    }
    
    //cell contents 설정: 조건문을 통해 row마다 cell contents를 다르게 설정할 수 있다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt", indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell")!
        cell.backgroundColor = .black
        
        if indexPath.section == 0 {
            //row number와 array index 위치를 맞춰놓으면 배열값을 일일이 대입하지 않아도 indexPath.row로 표시할 수 있다.
            cell.textLabel?.text = generalSettingArray[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = privateSettingArray[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = othersSettingArray[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        } else {
            cell.textLabel?.text = "잘못된 값입니다."
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        }
        
        //return cell을 쓰는 이유? -> 속성 적용을 해주었으므로 속성이 적용된 변수를 반환해야 하기 때문이다.
        return cell
    }
    
    //셀 높이 조정 함수: viewDidLoad에서 rowHeight 선언한 것보다 우선 적용됨
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
