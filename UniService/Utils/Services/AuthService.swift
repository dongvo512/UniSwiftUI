//
//  AuthService.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation

class AuthService:NSObject{
    static let shared = AuthService()
    
    func isLogged() -> Bool{
        
        return (LocaleStorageService.shared.getAccessTokenCurr() != nil)
    }
}
