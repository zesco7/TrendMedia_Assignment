//
//  ShoppingTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

/*쇼핑목록리스트 포인트
 -. 테이블뷰 row끼리 간격을 줄 수 없으니 view위에 객체를 얹어서 간격이 있는 것처럼 보이게 만들어 준다.
 -. 데이터를 배열에 추가,삭제 한 뒤 reloadData를 사용하여 tableView화면에 변경된 데이터를 보여주도록 해야한다!!!!
 */

/*질문
 -. 텍스트필드쪽 뷰와 섹션 사이 간격 어떻게 만드는지?
 -. cell row 속성에 inset grouped을 코드로 어떻게 적용하는지?
 -. cell row 속성에 row구분선 밑줄을 코드로 어떻게 적용하는지?
 -> 해결: 테이블뷰 row끼리 간격을 줄 수 없으니 view위에 객체를 얹어서 간격이 있는 것처럼 보이게 만들어 주고 속성을 따로 적용한다.
 */

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var shoppingListTextField: UITextField!
    @IBOutlet weak var shoppingListAddButton: UIButton!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이폰 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "쇼핑"
        
        headerViewAttribute()
        shoppingListTextFieldAttribute()
        shoppingListAddButtonAttribute()
    }
    
    func headerViewAttribute() {
        headerView.backgroundColor = .systemGray5
        headerView.layer.cornerRadius = 10
    }
    
    func shoppingListTextFieldAttribute() {
        shoppingListTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingListTextField.backgroundColor = .clear
        shoppingListTextField.borderStyle = .none
    }
    
    func shoppingListAddButtonAttribute() {
        shoppingListAddButton.setTitle("추가", for: .normal)
        shoppingListAddButton.setTitleColor(.black, for: .normal)
        shoppingListAddButton.backgroundColor = .systemGray4
        shoppingListAddButton.layer.borderWidth = 0
        shoppingListAddButton.layer.cornerRadius = 10
    }
    
    
    //row 생성
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shoppingList.count
    }
    
    //swipe제거 기능 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //cell contents 생성(재사용)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        cell.cellView.backgroundColor = .systemGray5
        cell.cellView.layer.cornerRadius = 10
        cell.checkBoxButton.image = UIImage(systemName: "checkmark.square")
        cell.checkBoxButton.tintColor = .black
        cell.buyList.text = shoppingList[indexPath.row]
        cell.buyList.backgroundColor = .clear
        cell.buyList.font = .systemFont(ofSize: 15)
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.starButton.tintColor = .black
        
        return cell
    }
    
    //텍스트필드값 tableViewCell 표시
    @IBAction func shoppingListTextFieldReturn(_ sender: UITextField) {
        shoppingList.append(shoppingListTextField.text!)
        tableView.reloadData()
    }
}
