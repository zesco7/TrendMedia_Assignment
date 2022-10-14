//
//  ShoppingContentsViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/05.
//

import UIKit
import RealmSwift

class ShoppingContentsViewController: UIViewController {
    static var identifier = "ShoppingContentsViewController"

    @IBOutlet weak var checkboxTitleLabel: UILabel!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkboxLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var checkbox: Bool?
    var contents: String?
    var favorite: Bool?
    
    let localRealm = try! Realm()
    
    var data: Results<ShoppingList>! {
        didSet {
            tableView.reloadData()
            print("Data Changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelAttribute()
        checkboxTitleLabel.text = "체크박스 선택여부(T/F)"
        contentsTitleLabel.text = "내용"
        favoriteTitleLabel.text = "즐겨찾기 선택여부(T/F)"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShoppingContentsTableViewCell.self, forCellReuseIdentifier: "ShoppingContentsTableViewCell")
        fetchRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkboxLabel.text = "\(checkbox!)"
        contentsLabel.text = "\(contents!)"
        favoriteLabel.text = "\(favorite!)"
    }
    
    func fetchRealm() {
        data = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "checkbox", ascending: true)
    }
    func labelAttribute() {
        checkboxTitleLabel?.numberOfLines = 0
        contentsTitleLabel?.numberOfLines = 0
        favoriteTitleLabel?.numberOfLines = 0
        checkboxTitleLabel.textAlignment = .center
        contentsTitleLabel.textAlignment = .center
        favoriteTitleLabel.textAlignment = .center
        checkboxTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentsTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        favoriteTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        checkboxTitleLabel.backgroundColor = .systemGray3
        contentsTitleLabel.backgroundColor = .systemGray3
        favoriteTitleLabel.backgroundColor = .systemGray3
        
        checkboxLabel.numberOfLines = 0
        contentsLabel.numberOfLines = 0
        favoriteLabel.numberOfLines = 0
        checkboxLabel.textAlignment = .center
        contentsLabel.textAlignment = .center
        favoriteLabel.textAlignment = .center
        checkboxLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentsLabel.font = .systemFont(ofSize: 16, weight: .bold)
        favoriteLabel.font = .systemFont(ofSize: 16, weight: .bold)
        checkboxLabel.backgroundColor = .yellow
        contentsLabel.backgroundColor = .yellow
        favoriteLabel.backgroundColor = .yellow
    }
}

extension ShoppingContentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingContentsTableViewCell.identifier, for: indexPath) as? ShoppingContentsTableViewCell else { return UITableViewCell() }
        
        //cell.thumbnail.image = loadImageFromDocument2(fileName: "\(data[indexPath.row].objectId).jpg")
        print("\(data[indexPath.row].objectId).jpg")
        return cell
    }
    
    
}
 
