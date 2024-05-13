//
//  Paging.swift
//  UniService
//
//  Created by Admin on 29/02/2024.
//

import Foundation
import ObjectMapper

struct Paging : Mappable {
    
    var limit : Int = 20
    var page : Int = 1
    var totalRows : Int = 0
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        
        limit <- map["limit"]
        page <- map["page"]
        totalRows <- map["totalRows"]
    }
}
