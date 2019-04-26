//
//  Item.swift
//  WannaDo
//
//  Created by 黃品綸 on 2019/4/26.
//  Copyright © 2019 Pinlun Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
