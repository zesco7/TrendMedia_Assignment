//
//  BucketListTableViewCell.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

/*에러 종류별 원인, 해결방법
 -. could not insert new outlet connection: TableViewController-Storyboard 미연결 -> TableViewController-Storyboard 연결
 -. must register a nib: 1. identifier 등록 안함 -> identifier 등록 2. dequeueReusableCell에서 identifier 철자 오류 -> identifier 철자 수정
 */


