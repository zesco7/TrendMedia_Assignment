//
//  RecommendationCollectionViewController.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/09/01.
//

import UIKit

import Kingfisher
import Toast

/*CollectionView 포인트
 -. 레이아웃 설정: UICollectionViewFlowLayout사용하여 셀크기,간격 잡기
 -. 네트워크로 이미지 가져오기: kingfisher사용하여 이미지url에 있는 이미지 불러오기
 */
class RecommendationCollectionViewController: UICollectionViewController {
    
    static var identifier = "RecommendationCollectionViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //콜렉션뷰의 셀 크기, 셀 간격 설정
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4) //화면전체크기 기준으로 너비 지정
        layout.itemSize = CGSize(width: width / 3, height: 150)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCollectionViewCell", for: indexPath) as! RecommendationCollectionViewCell
        
        let url = URL(string: "https://img.fruugo.com/product/9/75/101193759_max.jpg")
        cell.backgroundColor = .orange
        cell.movieImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView선택시 토스트 표시
        view.makeToast("\(indexPath)번째 셀을 선택했습니다", duration: 1, position: .center)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
