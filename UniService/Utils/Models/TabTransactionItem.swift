//
//  TabTransactionItem.swift
//  UniService
//
//  Created by Admin on 26/02/2024.
//

import Foundation

struct TabTransactionItem: Identifiable, Hashable {
    
    var id = UUID()
    var type:TabTransactionType = .all
}

enum TransactionKeyType {
    case purchase
    case deposit
    case tranfer_receive
    case service
    case vexere
    case vending_machine
    
    var key:String{
        switch self {
        case .purchase:
            "BUY"
        case .deposit:
            "DEPOSIT"
        case .tranfer_receive:
            "TRANSFER"
        case .vexere:
            "SERVICES:VEXERE"
        case .service:
            "SERVICES"
        case .vending_machine:
            "VENDING_MACHINE"
        }
    }
    
    var name:String{
        switch self {
        case .purchase:
            "BUY"
        case .deposit:
            "DEPOSIT"
        case .tranfer_receive:
            "TRANSFER"
        case .vexere:
            "SERVICES:VEXERE"
        case .service:
            "SERVICES:VEXERE"
        case .vending_machine:
            "VENDING_MACHINE"
        }
    }
}

enum TabTransactionType {
    
    case all
    case purchase
    case deposit
    case tranfer_receive
    case service
    case vending_machine
    
    var key:String {
        switch self {
        case .all:
           return S.empty
        case .purchase:
            return  TransactionKeyType.purchase.key
        case .deposit:
            return TransactionKeyType.deposit.key
        case .tranfer_receive:
            return TransactionKeyType.tranfer_receive.key
        case .service:
            return TransactionKeyType.service.key
        case .vending_machine:
            return TransactionKeyType.vending_machine.key
        }
    }
    
    var title:String{
        switch self {
        case .all:
            "all".localized()
        case .purchase:
            "purchase".localized()
        case .deposit:
            "deposit".localized()
        case .tranfer_receive:
            "send/receive".localized()
        case .service:
            "service".localized()
        case .vending_machine:
            "vending_machine".localized()
        }
    }
    
    var index:Int{
        switch self {
        case .all:
            0
        case .purchase:
            1
        case .deposit:
            2
        case .tranfer_receive:
            3
        case .service:
            4
        case .vending_machine:
            5
        }
    }
}
