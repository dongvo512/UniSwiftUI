//
//  AppEnviroment.swift
//  UniService
//
//  Created by Admin on 09/01/2024.
//

import Foundation

struct AppEnviroment {
#if DEV
    static let baseURL = "https://api.dev.uniservice.vn"
#elseif STG
    static let baseURL = "https://api.stg.uniservice.vn"
#else
    static let baseURL = "https://api.uniservice.vn"
#endif
    
}
