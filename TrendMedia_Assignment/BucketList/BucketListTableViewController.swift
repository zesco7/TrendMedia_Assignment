//
//  BucketListTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {
    
    static var identifier = "BucketListTableViewController"
    
    //UITextField는 클래스이므로 클래스 자체가 변경되지 않는 이상 텍스트필드값이 변경되어도 처음 한번만 didSet이 호출됨(구조체는 변경될때마다 호출됨)
    //@IBOutlet는 viewDidLoad호출 직전에 nil인지 아닌지 알 수 있음
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("텍스트필드 didSet")
        }
    }
    
    //list프로퍼티가 추가, 삭제 될 때마다 테이블뷰를 항상 갱신해줘야 한다.(property observer사용)
    var list = [Todo(title: "범죄도시", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨 \(list), \(oldValue)")
        }
    }
    
    //1. TrendTVC -> BucketListTVC 값 전달: 프로퍼티 생성
    //옵셔널 스트링타입이더라도 오류 없는 이유?
    //placeholder자체가 옵셔널이라면?
    //string interpolation을 사용한다면? : string interpolation에는 nil이 올 수 없으므로 (textFieldPlaceholder ?? "영화")처럼 nil일 때 조건처리를 해주어야 한다.
    var textFieldPlaceholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        list.append("마녀")
//        list.append("헤어질 결심")
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        //3. TrendTVC -> BucketListTVC 값 전달: 프로퍼티 값을 뷰에 표현
        userTextField.placeholder = textFieldPlaceholder
        userTextField.placeholder = "\(textFieldPlaceholder ?? "영화")를 입력해보세요"
    }
    
    @objc
    func closeButtonClicked() {
        self.dismiss(animated: true) //TrendTableViewController에 연결되어 있던 본인을 dismiss처리한다. 그러면 시작화면이었던 TrendTableViewController로 화면전환된다.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //화면 표현 속성을 바꾸는 건 cellForRowAt에 구현하는게 좋음
        //indexPath매개변수는 없어도 되지만 있으면 인덱스를 사용해서 셀마다 다른 값을 줄 수 있음.
        //tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath): 화면에서 셀 가져옴
        //as! BucketListTableViewCell: 가져온 셀을 클래스파일에 연결.
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 20)
        
        cell.checkboxButton.tag = indexPath.row //각 셀의 인덱스대로 태그 지정
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked(sender:)), for: .touchUpInside) //함수타입인 (sender:) 까지 셀렉터에 전달해주는게 일반적임

        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func checkboxButtonClicked(sender: UIButton) { //cell.checkboxButton.tag에서 태그를 매개변수로 받음
        print("\(sender.tag)버튼클릭")
        
        //배열인덱스를 찾아서 done을 바꾸고 테이블 뷰 갱신하기
        list[sender.tag].done = !list[sender.tag].done //반대값 대입
        
        //tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade) //전체행이 아니라 선택행 데이터만 변경(데이터 관리를 효율적으로 할 수 있음)
        
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) //재사용 셀 오류확인용 코드
    }
    
    
    //row수정 함수: 추가 구현해야 작동함
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
         
    }
    
    //row삭제 함수: right to left로 swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row) //해당 index의 row 삭제
            //tableView.reloadData()
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
        
        //case2. if let 옵셔널 바인딩 사용하여 배열 추가하면 sender.text!처럼 강제해제 해줄필요 없음
        //if let value = sender.text {
            //list.append(value)
            //tableView.reloadData()
        //} else {
            //토스트 메시지 띄우기
        //}
        
        /*
        //case3. guard let
        guard let vvalue != sender.text else {
            //alert, toast통해 정보를 사용자에게 알려줘야 한다.(ex. 빈값입니다, 글자수가 많습니다 등)
            return
        }
        */
        
        //case1. 강제 해제
        //list.append(sender.text!) //sender인 텍스트필드값을 list배열에 추가
        list.append(Todo(title: sender.text!, done: false))
        //tableView.reloadData() //테이블뷰 갱신
        //tableView.reloadSections(IndexSet, with: <#T##UITableView.RowAnimation#>)
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
        print(list)
    }
}
