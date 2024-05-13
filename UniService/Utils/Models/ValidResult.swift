//
//  ValidResult.swift
//  PiHome
//
//  Created by Dong vo on 03/08/2021.
//

import UIKit
import ObjectMapper

class ValidResult: NSObject,Mappable {

    var field:String?
    var message:String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        self.field <- map["field"]
        self.message <- map["message"]
    }
}

/*
 {
   "code": 422,
   "errors": [
     {
       "field": "email",
       "message": "email must be an email"
     }
   ],
   "message": null
 }
 */
