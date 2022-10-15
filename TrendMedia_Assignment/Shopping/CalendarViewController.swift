//
//  CalendarViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/15.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    let mainView = CalendarView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let dateFormatted = dateFormatter.string(from: date)
        return dateFormatted == "221010" ? UIImage(systemName: "star.fill") : nil //기준으로 정한 날짜에 따라 이미지 적용
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(#function)
        //repository에 있는 필터링 메서드로 date매개변수에 해당하는 realm데이터 받기
    }
}

