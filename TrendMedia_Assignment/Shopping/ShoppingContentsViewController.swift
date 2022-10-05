//
//  ShoppingContentsViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/05.
//

import UIKit

class ShoppingContentsViewController: UIViewController {
    static var identifier = "ShoppingContentsViewController"

    @IBOutlet weak var checkboxTitleLabel: UILabel!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var checkboxLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var checkbox: Bool?
    var contents: String?
    var favorite: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelAttribute()
        checkboxTitleLabel.text = "체크박스 선택여부(T/F)"
        contentsTitleLabel.text = "내용"
        favoriteTitleLabel.text = "즐겨찾기 선택여부(T/F)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkboxLabel.text = "\(checkbox!)"
        contentsLabel.text = "\(contents!)"
        favoriteLabel.text = "\(favorite!)"
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
