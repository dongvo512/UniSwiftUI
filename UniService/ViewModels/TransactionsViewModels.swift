//
//  TransactionsViewModels.swift
//  UniService
//
//  Created by Admin on 27/02/2024.
//

import Foundation
import ObjectMapper

class TransactionsViewModel: ObservableObject, Identifiable {
    
    init(tabType:TabTransactionType, fromDate:Date, toDate:Date) {
        self.tabType = tabType
        // fetchData(fromDate: fromDate, toDate: toDate)
    }
    
    var tabType:TabTransactionType = TabTransactionType.all
//    @Published var fromDate:Date {
//        didSet{
//            fetchData()
//        }
//    }
//    
//    @Published var toDate:Date {
//        didSet{
//            fetchData()
//        }
//    }
    
    @Published var stateTransactions:BaseState = .onIdle
    @Published var transactions:[Transaction] = []
    
    private let limitItem:Int = 20
    
    public func fetchData(fromDate:Date, toDate:Date) {
        
        stateTransactions = .onLoading
        
        TransactionsRepository.shared.fetchData(type: tabType,indexPage: 1, limitItem: limitItem, fromDate: fromDate.formatDateToString(), toDate: toDate.formatDateToString()) { resultApi in
          //  print("resultApi: ", resultApi)
            
            switch resultApi {
            case .onSuccess(let transactions):
                if let transactionsData = transactions {
                    self.transactions = transactionsData
                }
                self.stateTransactions = .onSuccess(transactions)
            case .onError(let e):
                self.stateTransactions = .onError(e)
            }
        }
    }
}
