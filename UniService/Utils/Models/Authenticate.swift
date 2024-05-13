//
//  Authenticate.swift
//  UniService
//
//  Created by Admin on 24/01/2024.
//

import Foundation
import ObjectMapper

struct Authenticate: Mappable {
    var access_token : String?
    var refresh_token : String?
    var expires_in : Int?
  
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        access_token <- map["access_token"]
        refresh_token <- map["refresh_token"]
        expires_in <- map["expires_in"]
    }
}
