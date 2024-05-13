//
//  ExString.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation
import SwiftUI

extension String {
    
    func localized(_ lang:String) ->String {
        
        var string = ""
        
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            
            let bundle = Bundle(path: path)
            string = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        
        return string
    }
    
    func localized() ->String {
        
        var string = ""
        
        if let path = Bundle.main.path(forResource: LanguageService.shared.currentLanguage, ofType: "lproj") {
            
            let bundle = Bundle(path: path)
            string = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        
        return string
    }
    
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        return self.compare(otherVersion, options: .numeric)
    }
    
    func security() -> String{
        return String(repeating: "*", count: self.count)
    }
    
    func utcToLocal(formatUTC:String = FormatDateType.isolated.value,formatString:String = FormatDateType.primary_app.value) -> String {
        
        guard self.count > 0 && formatUTC.count > 0 && formatString.count > 0 else {
            return ""
        }
        
        var strDate = ""
        
        if(self != "") {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formatUTC
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            if let dt = dateFormatter.date(from: self){
                
                dateFormatter.timeZone = NSTimeZone.local
                dateFormatter.dateFormat = formatString
                strDate = dateFormatter.string(from: dt)
            }
            else{
                
                strDate = ""
            }
        }
        
        return strDate
    }
    
    // MARK: - Validate
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isLengthMin8() -> Bool {
        return self.count >= 8
    }
    
    func getValidEmail() -> String {
    
        if self.isValidEmail() == false{
            return "invalid_email_address".localized()
        }
        else{
            return S.empty
        }
    }
    
    func getValidPassword() -> String {
    
        if self.isLengthMin8() == false{
            return "invalid_password".localized()
        }
        else{
            return S.empty
        }
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
