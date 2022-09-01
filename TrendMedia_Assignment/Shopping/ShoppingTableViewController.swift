//
//  ShoppingTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

/*질문
 -. 텍스트필드쪽 뷰와 섹션 사이 간격 어떻게 만드는지?
 -. cell row 속성에 inset grouped을 코드로 어떻게 적용하는지?
 -. cell row 속성에 row구분선 밑줄을 코드로 어떻게 적용하는지?
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        cell.backgroundColor = .systemGray5
        cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        cell.checkBoxButton.tintColor = .black
        cell.buyList.text = shoppingList[indexPath.row]
        cell.buyList.backgroundColor = .clear
        cell.buyList.borderStyle = .none
        cell.buyList.font = .systemFont(ofSize: 15)
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.starButton.tintColor = .black
        
        return cell
    }
}
