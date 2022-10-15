//
//  ShoppingRepository.swift
//  TrendMedia_Assignment
//
//  Created by Mac Pro 15 on 2022/10/15.
//

import Foundation
import RealmSwift

class ShoppingRepository {
    
    let localRealm = try! Realm()
    
    func fetchSorting(_ sort: String, ascending: Bool) -> Results<ShoppingList> {
        return localRealm.objects(ShoppingList.self).sorted(byKeyPath: sort, ascending: ascending)
    }
}
