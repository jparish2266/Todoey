//
//  Category.swift
//  Todoey
//
//  Created by Jessica Parish on 21/05/2018.
//  Copyright © 2018 Jessica Parish. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
