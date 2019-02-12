//
//  Category.swift
//  Todoey
//
//  Created by Codehouse on 2/12/19.
//  Copyright © 2019 Codehouse. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
