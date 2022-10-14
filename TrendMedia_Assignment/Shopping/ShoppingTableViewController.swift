//
//  ShoppingTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit
import RealmSwift

/*쇼핑목록리스트 포인트
 -. 테이블뷰 row끼리 간격을 줄 수 없으니 view위에 객체를 얹어서 간격이 있는 것처럼 보이게 만들어 준다.
 -. 데이터를 배열에 추가,삭제 한 뒤 reloadData를 사용하여 tableView화면에 변경된 데이터를 보여주도록 해야한다!!!!
 -. 버튼액션: localRealm에 있는 데이터를 변경해야하기 때문에 try! self.localRealm.write에서 데이터 업데이트하고 화면 갱신해준다.(sender.tag 사용하여 인덱싱)
 -. 액션시트: 기준에 따라 정렬한 localRealm데이터를 화면에 보여준다.
 -. 셀클릭시 데이터전달+화면전환: 데이터 받을 화면에서 프로퍼티 만들고 데이터 넘길화면에서 localRealm에 있는 데이터 인덱싱해서 넘겨준다. + 현재 뷰컨트롤러에 네비게이션 연결확인하고 화면전환 처리한다.
 */

/*질문
 -. 텍스트필드쪽 뷰와 섹션 사이 간격 어떻게 만드는지?
 -. cell row 속성에 inset grouped을 코드로 어떻게 적용하는지?
 -. cell row 속성에 row구분선 밑줄을 코드로 어떻게 적용하는지?
 -> 해결: 테이블뷰 row끼리 간격을 줄 수 없으니 view위에 객체를 얹어서 간격이 있는 것처럼 보이게 만들어 주고 속성을 따로 적용한다.
 -. shoppingListArray에 didSet으로 값변경시 reloadData코드 있으니 checkboxButtonClicked, starButtonClicked에서 reloadData없어도 화면갱신이 되어야하는것 아닌지?
 */

class ShoppingTableViewController: UITableViewController {
    static var identifier = "ShoppingTableViewController"
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var shoppingListTextField: UITextField!
    @IBOutlet weak var shoppingListAddButton: UIButton!
    
    //1. Realm파일 저장경로 설정
    let localRealm = try! Realm()
    
    var shoppingListArray : Results<ShoppingList>! {
        didSet {
            tableView.reloadData()
            print("DATA CHANGED")
        }
    }
    var dummy = Array<String>()
    
    let tvcell = ShoppingTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        navigationItem.title = "쇼핑"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(arrangementBarButtonClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "백업/복구", style: .plain, target: self, action: #selector(goToBackupPage))
        
        headerViewAttribute()
        shoppingListTextFieldAttribute()
        shoppingListAddButtonAttribute()
        shoppingListAddButton.addTarget(self, action: #selector(shoppingListAddButtonClicked), for: .touchUpInside) //추가버튼 클릭시 쇼핑목록 생성 구현
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        shoppingListArray = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents", ascending: true)
        print(shoppingListArray)
    }
    @objc func goToBackupPage() {
        //let vc = BackupViewController()으로 present하면 화면에 버튼안뜨는이유?
        let sb = UIStoryboard(name: "Shopping", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier:  BackupViewController.identifier) as! BackupViewController
        self.navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true)
    }
    
    @objc func arrangementBarButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let checkbox = UIAlertAction(title: "체크기준 정렬", style: .default) { _ in
            self.shoppingListArray = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "checkbox", ascending: false)
            print("CHECKBOX CLICKED")
        }
        let title = UIAlertAction(title: "제목 순 정렬", style: .default) { _ in
            self.shoppingListArray = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "shoppingContents", ascending: true)
            print("TITLE CLICKED")
        }
        let favorite = UIAlertAction(title: "즐겨찾기 순 정렬", style: .default) { _ in
            self.shoppingListArray = self.localRealm.objects(ShoppingList.self).sorted(byKeyPath: "favorite", ascending: false)
            print("FAVORITE CLICKED")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("CANCEL CLICKED")
        }
        
        alert.addAction(checkbox)
        alert.addAction(title)
        alert.addAction(favorite)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc func shoppingListAddButtonClicked() {
        //        shoppingList.append(shoppingListTextField.text!)
        
        //Realm파일 테이블 레코드 생성
        let shoppingList = ShoppingList(checkbox: false, shoppingContents: shoppingListTextField.text!, favorite: false)
        
        //Realm파일 테이블 레코드 추가
        
        do {
            try localRealm.write {
                localRealm.add(shoppingList)
            }
        } catch let error {
            print(error)
        }
        
//        if let image = tvcell.shoppingImage.image {
//            saveImageToDocument(fileName: "\(shoppingList.objectId).jpg", image: image)
//            print("Realm Success")
//            tableView.reloadData()
//        }
        tableView.reloadData()
        view.endEditing(true)
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
        return shoppingListArray.count
    }
    
    //swipe제거 기능 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! localRealm.write {
                localRealm.delete(shoppingListArray[indexPath.row]) //indexPath에 맞는 Realm레코드 삭제
                print("Realm Deleted")
                tableView.reloadData()
            }
        }
    }
    
    //cell contents 생성(재사용)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.cellView.backgroundColor = .systemGray5
        cell.cellView.layer.cornerRadius = 10
        
        let checkboxButtonImage = shoppingListArray[indexPath.row].checkbox! ? "checkmark.square" : "square"
        cell.checkboxButton.setImage(UIImage(systemName: checkboxButtonImage), for: .normal)
        cell.checkboxButton.tintColor = .black
        cell.checkboxButton.tag = indexPath.row
        
        cell.buyList.text = shoppingListArray[indexPath.row].shoppingContents
        cell.buyList.backgroundColor = .clear
        cell.buyList.font = .systemFont(ofSize: 15)
        
        let starButtonImage = shoppingListArray[indexPath.row].favorite! ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: starButtonImage), for: .normal)
        cell.starButton.tintColor = .black
        cell.starButton.tag = indexPath.row
        
        let thumbnail = indexPath.row % 2 == 0 ? "괴물" : "왕의남자"
        cell.shoppingImage.image = UIImage(named: thumbnail) //쇼핑목록 추가시 랜덤으로 이미지보여주기
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀클릭시 데이터전달+화면전환
            let sb = UIStoryboard(name: "Shopping", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "ShoppingContentsViewController") as! ShoppingContentsViewController
            vc.checkbox = shoppingListArray[indexPath.row].checkbox
            vc.contents = shoppingListArray[indexPath.row].shoppingContents
            vc.favorite = shoppingListArray[indexPath.row].favorite
            
            self.navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
 
    @IBAction func checkboxButtonClicked(_ sender: UIButton) {
        try! self.localRealm.write {
        shoppingListArray[sender.tag].checkbox = !shoppingListArray[sender.tag].checkbox!
            tableView.reloadData()
        }
    }
    
    @IBAction func starButtonClicked(_ sender: UIButton) {
        try! self.localRealm.write {
        shoppingListArray[sender.tag].favorite = !shoppingListArray[sender.tag].favorite!
            tableView.reloadData()
        }
    }
    
    //텍스트필드값 tableViewCell 표시
    @IBAction func shoppingListTextFieldReturn(_ sender: UITextField) {
        let shoppingList2 = ShoppingList(checkbox: false, shoppingContents: shoppingListTextField.text!, favorite: false)
        
        //Realm파일 테이블 레코드 추가
        do {
            try localRealm.write {
                localRealm.add(shoppingList2)
            }
        } catch let error {
            print(error)
        }
        
//        if let image = tvcell.shoppingImage.image {
//            saveImageToDocument(fileName: "\(shoppingList2.objectId).jpg", image: image)
//            print("Realm Success")
//            tableView.reloadData()
//        }
    }
}

extension ShoppingTableViewController {
    //키보드 내리기 탭제스처 구현
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
}
