//
//  UITextField+Extension.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//


import UIKit

extension UITextField {
    
    //익스텐션에는 저장프로퍼티 포함할 수 없다.(Extensions must not contain stored properties.)
    //let placeholder = "이메일을 입력해주세요"
    
    func borderColor() {
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
        //self.placeholder = placeholder
    }
}
