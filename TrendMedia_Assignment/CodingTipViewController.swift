//
//  CodingTipViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/08/31.
//

import UIKit

/*클래스선언할 때 왜 init을 쓰지 않을까?
-. init은 괄호앞에 생략되어 있음(ex. DateFormatter() -> DateFormatter.init())
 */

/*변수의 스코프: 왜 class에서 초기화된 변수의 속성을 바꿀 수 없을까?
-. 언제 실행될지 모르기 때문에(프로퍼티를 초기화 할때 값까지 변경할수 없기 때문에) class가 아닌 viewDidLoad에서 바꿔야한다.
*/


class CodingTipViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var purpleViewLeadingConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //constraint도 아웃렛변수 선언하여 값을 대입할 수 있다.
        purpleViewLeadingConstant.constant = 120
        configureLabelDesign()
    }
    
    /*언제 아울렛 콜렉션을 사용하는게 좋은가?
     -. 위치가 바뀌지 않을경우만 사용하는 것이 좋다. 1,2가 3,4,5처럼 위치가 바뀌는 경우 정해놓은 배열과 새로운 위치가 안맞을 수 있기 때문이다.
     -. 배열을 만들어 반복문으로 속성은 적용하되, 값은 배열인덱스를 사용하지 않고 직접 대입하는 것이 좋다. 그래야 위치가 바뀌어도 값이 달라지지 않기 때문이다.
     */
    
    func configureLabelDesign() {
        //1. OutletCollection: OutletCollection가 UILabel의 배열 타입임을 사용하여 반복문처리한다.
        //콜렉션으로 묶여있기 때문에 반복문에서 i는 각각의 아웃렛을 의미한다. 개별 아웃렛에 속성을 적용하는 것.
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        dateLabelCollection[0].text = "첫번째 텍스트"
        dateLabelCollection[1].text = "두번째 텍스트"
        print(type(of: dateLabelCollection[0]))
        
        
        //2. UILabel: OutletCollection대신 UILabel을 배열로 선언하고 반복문처리한다.
        let labelArray = [dateLabel, dateLabel2]
        for i in labelArray {
            i?.font = .boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
        dateLabel.text = "첫번째 텍스트"
        dateLabel2.text = "두번째 텍스트"
    }
}

