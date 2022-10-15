//
//  CalendarView.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/15.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarView: UIView {
    let calendar : FSCalendar = {
        let view = FSCalendar()
        return view
    }()
    
    override init(frame: CGRect) { //기본뷰 커스텀할때는 초기화해줘야함
        super.init(frame: .zero)
        configureUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(calendar)
    }
    
    func setConstraint() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
    }
}
