//
//  SearchTableViewCell.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOpeningDayLabel: UILabel!
    @IBOutlet weak var movieStoryLabel: UILabel!
    
    //cell속성을 함수로 묶어서 cell 재사용시 호출한다.
    //cellForRowAt에 선언한 data변수의 자료형이 Movie Struct이기 때문에 매개변수 data의 자료형을 Movie Struct로 하여 movieList배열 안에 있는 모든 값에 접근하게 만든다.
    func configureCell(data: Movie) {
        moviePosterImageView.image = UIImage(named: "극한직업")
        movieTitleLabel.text = data.title
        movieOpeningDayLabel.text = "\(data.releaseDate) | \(data.runtime) | \(data.rate)"
        movieStoryLabel.text = data.overview
        movieStoryLabel.numberOfLines = 0
    }
}
