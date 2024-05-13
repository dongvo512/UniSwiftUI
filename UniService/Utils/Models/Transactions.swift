//
//  Transactions.swift
//  UniService
//
//  Created by Admin on 29/02/2024.
//

import Foundation
import ObjectMapper

struct Transactions : Mappable {
   
    var data : Array<TransactionOjb> = []
    var paginate : Paging?
    
    init?(map: Map) {

    }

    init() {
        
    }
    
    mutating func mapping(map: Map) {
        
        data <- map["data"]
        paginate <- map["paginate"]
    }
}
