//
//  Item.swift
//  WannaDo
//
//  Created by 黃品綸 on 2019/4/24.
//  Copyright © 2019 Pinlun Huang. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
