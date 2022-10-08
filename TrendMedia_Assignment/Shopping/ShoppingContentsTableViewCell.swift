//
//  ShoppingContentsTableViewCell.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/08.
//

import UIKit

class ShoppingContentsTableViewCell: UITableViewCell {
    static var identifier = "ShoppingContentsTableViewCell"

    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
