//
//  Promotion.swift
//  UniService
//
//  Created by Admin on 18/01/2024.
//

import Foundation
import ObjectMapper

struct Promotion : Mappable, Identifiable {
    var id : String?
    var title : String?
    var imageURL : String?
    var redirectURL : String?
    var isActive : Bool?
    var createdAt : String?
    var updatedAt : String?

    init(title:String) {
        self.title = title
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        imageURL <- map["imageURL"]
        
        if let imgURL = imageURL {
            
            self.imageURL = imgURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        }
    
        redirectURL <- map["redirectURL"]
        isActive <- map["isActive"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }

}
