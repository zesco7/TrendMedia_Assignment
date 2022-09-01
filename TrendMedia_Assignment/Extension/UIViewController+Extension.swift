//
//  UIViewController+Extension.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit

extension UIViewController {

    func setBackgroundColor() {
        view.backgroundColor = .lightGray
    }
    
    //여러 화면을 띄우려면 title, message에 매개변수 추가해서 사용하면 됨.
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
