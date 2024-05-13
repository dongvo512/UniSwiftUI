//
//  ExInt.swift
//  UniService
//
//  Created by Admin on 11/01/2024.
//

import Foundation

extension Int {
    
    func secondsToHourTime() -> String {
        
        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        
        return "\(h_string):\(m_string):\(s_string)"
        // return "\(m_string):\(s_string)"
    }
    
    func secondsToTime() -> String {
        
        let (_,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        // let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        
        //return "\(h_string):\(m_string):\(s_string)"
        return "\(m_string):\(s_string)"
    }
    
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}
