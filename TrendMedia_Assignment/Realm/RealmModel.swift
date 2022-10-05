//
//  RealmModel.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/02.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    //1.테이블 만들기(컬럼)
    @Persisted var checkbox: Bool?
    @Persisted var shoppingContents: String
    @Persisted var favorite: Bool?
    
    //2.PK등록
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    //3.초기화
    convenience init(checkbox: Bool?, shoppingContents: String, favorite: Bool?) {
        self.init()
        self.checkbox = true
        self.shoppingContents = shoppingContents
        self.favorite = false
    }
}
