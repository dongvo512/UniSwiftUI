//
//  User.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import Foundation
import ObjectMapper

struct UserInfo : Mappable, Codable {
    var id : String?
    var username : String?
    var email : String?
    var firstName : String?
    var point : Double = 0.0
    var lastName : String?
    var fullName : String?
    var phone : String?
    var avatar : String?
    var studentId : String?
    var role : String?
    var isGuest : Bool?
    var isBlocked : Bool?
    var isVerified : Bool?
    var otpCode : String?
    var otpDate : String?
    var createdAt : String?
    var updatedAt : String?
    var birthdate : String?
    var position : String = ""
    var faculty : String = ""
    var identificationCard : String = ""
    var school : String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        position <- map["position"]
        faculty <- map["faculty"]
        school <- map["school"]
        identificationCard <- map["identificationCard"]
        username <- map["username"]
        email <- map["email"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        phone <- map["phone"]
        avatar <- map["avatar"]
        
        if let avatar = avatar {
            
            self.avatar = avatar.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        }
        
        studentId <- map["studentId"]
        role <- map["role"]
        isGuest <- map["isGuest"]
        isBlocked <- map["isBlocked"]
        isVerified <- map["isVerified"]
        otpCode <- map["otpCode"]
        otpDate <- map["otpDate"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        fullName <- map["fullName"]
        point <- map["point"]
        birthdate <- map["birthdate"]
    }
}
