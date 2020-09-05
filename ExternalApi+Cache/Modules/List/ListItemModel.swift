//
//  ListItemModel.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation
import ObjectMapper

struct ListItemModel {
    var id: Int = 0
    var title: String = ""
    var imageUrl: String = ""
}

extension ListItemModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        imageUrl <- map["url"]
    }
}
