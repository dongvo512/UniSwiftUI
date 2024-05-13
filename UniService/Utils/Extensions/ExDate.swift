//
//  ExDate.swift
//  UniService
//
//  Created by Admin on 26/02/2024.
//

import Foundation

enum FormatDateType {
case primary_app
case isolated
case time
    
    var value:String {
        switch self {
        case .primary_app:
            "dd/MM/yyyy"
        case .isolated:
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .time:
            "HH:mm"
        }
    }
}

extension Date {
    
    func formatDateToString(format:FormatDateType = .primary_app) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.value
       return dateFormatter.string(from: self)
        
    }
    
    func changeDate(days:Int = -30) -> Date{
        
        var dayComponent    = DateComponents()
        dayComponent.day    = days // For removing one day (yesterday): -1
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: self)
        
        return nextDate ?? Date()
    }
}
