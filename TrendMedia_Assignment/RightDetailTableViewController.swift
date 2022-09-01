//
//  RightDetailTableViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit

class RightDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetailCell")!
        
        cell.textLabel?.text = "안녕하세요"
        cell.detailTextLabel?.text = "디테일 레이블"
        
        //삼항연산자 사용하여 indexPath에 따라 cell속성 적용
        cell.imageView?.image = indexPath.row % 2 == 1 ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.backgroundColor = indexPath.row % 2 == 1 ? UIColor.systemGray : UIColor.yellow
        
    
        
        return cell
    }

   

}
