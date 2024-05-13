//
//  MenuItem.swift
//  UniService
//
//  Created by Admin on 15/01/2024.
//

import Foundation


struct TabMenuItem: Identifiable, Hashable {
    var id = UUID()
    var type:TabMenuType = .all
}

enum TabMenuType {
    
    case all
    case main
    case drink
    case foodcourt
    case specicalfood
    case promotion
    case neccessary
    
    var title:String{
        switch self {
        case .all:
            "all".localized()
        case .main:
            "tab_title_main".localized()
        case .drink:
            "drinks_menu".localized()
        case .foodcourt:
            "tab_title_foodcourt".localized()
        case .specicalfood:
            "speciality".localized()
        case .promotion:
            "promotion".localized()
        case .neccessary:
            "neccessary".localized()
        }
    }
    
    var iconName:String{
        switch self {
        case .all:
            "ic_home_all"
        case .main:
            "ic_home_maindish"
        case .drink:
            "ic_home_drink"
        case .foodcourt:
            "ic_home_foodcourt"
        case .specicalfood:
            "ic_home_specialty"
        case .promotion:
            "ic_home_promotion"
        case .neccessary:
            "ic_home_neccessary"
        }
    }
}
