//
//  RefreshTokenModel.swift
//  PiHome
//
//  Created by Dong vo on 17/08/2021.
//

import UIKit
import ObjectMapper

class RefreshTokenModel: NSObject, Mappable {

    var expires_in:Int = 0
    var access_token:String = ""
    var refresh_token:String = ""
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       
        self.expires_in <- map["expires_in"]
        self.access_token <- map["access_token"]
        self.refresh_token <- map["refresh_token"]
    }
}
