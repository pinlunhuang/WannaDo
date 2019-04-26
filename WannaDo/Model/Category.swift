//
//  Category.swift
//  WannaDo
//
//  Created by 黃品綸 on 2019/4/26.
//  Copyright © 2019 Pinlun Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
    
}
