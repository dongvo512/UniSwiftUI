//
//  LogService.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation

class LogService: NSObject{
    static let shared = LogService()
    
    func printLog(title:String, value:Any, url:String? = nil){
        #if DEBUG
        if let apiURL = url{
            print(" ##### API URL #####\n", apiURL)
        }
        print(" ##### \(title) #####\n", value)
        #endif
    }
}
