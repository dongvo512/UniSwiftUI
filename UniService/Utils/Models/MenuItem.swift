//
//  MenuType.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import Foundation

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var type:MenuType = .today
}
enum MenuType {
    
    case today
    case drink
    case foodcourt
    case specicalfood
    case promotion
    case neccessary
    
    var title:String{
        switch self {
        case .today:
            "sub_title_main_dish".localized()
        case .drink:
            "drinks_menu".localized()
        case .foodcourt:
            "today_food_court_menu".localized()
        case .specicalfood:
            "speciality".localized()
        case .promotion:
            "promotion".localized()
        case .neccessary:
            "neccessary".localized()
        }
    }
}
