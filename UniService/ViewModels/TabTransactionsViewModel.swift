//
//  TabTransactionsViewModel.swift
//  UniService
//
//  Created by Admin on 29/02/2024.
//

import Foundation

@MainActor final class TabTransactionsViewModel: ObservableObject {
    private let limitItem:Int = 20
    
    init() {
        self.fetchAll()
    }
    
    @Published var allTransactions:Transactions?
    @Published var purchaseTransactions:Transactions?
    @Published var depositTransactions:Transactions?
    @Published var tranferTransactions:Transactions?
    @Published var serviceTransactions:Transactions?
    @Published var vMachineTransactions:Transactions?
    @Published var fromDate:Date = Date().changeDate()
    @Published var toDate:Date = Date()
    @Published var stateTransactions:BaseState = .onIdle
    
    public func getTransactionsItemWithTabType(tabType:TabTransactionType) -> Array<TransactionOjb>?{
        
        switch tabType {
        case .all:
            self.allTransactions?.data ?? []
        case .purchase:
            self.purchaseTransactions?.data ?? []
        case .deposit:
            self.depositTransactions?.data ?? []
        case .tranfer_receive:
            self.tranferTransactions?.data ?? []
        case .service:
            self.serviceTransactions?.data ?? []
        case .vending_machine:
            self.vMachineTransactions?.data ?? []
        }
    }
    
    public func fetchAll()  {
        Task.detached (priority: .medium){
            await self.fetchDataWithTabType(tabType: .all)
            await self.fetchDataWithTabType(tabType: .purchase)
            await self.fetchDataWithTabType(tabType: .deposit)
            await self.fetchDataWithTabType(tabType: .tranfer_receive)
            await self.fetchDataWithTabType(tabType: .service)
            await self.fetchDataWithTabType(tabType: .vending_machine)
        }
    }
    
    public func shouldLoadMore(tabType:TabTransactionType, transaction:TransactionOjb){
        
        let transactionItems = self.getTransactionsItemWithTabType(tabType: tabType)
        let transactions = self.getTransactionsWithTabType(tabType: tabType)
        
        guard transaction == transactionItems?.last && transactions?.paginate?.totalRows ?? 0 > transactionItems?.count ?? 0  else {
          
            return
        }
        
        stateTransactions = .onLoading
        let indexPage = (transactions?.paginate?.page ?? 0) + 1
        
        TransactionsRepository.shared.fetchData(type: tabType,indexPage: indexPage, limitItem: limitItem, fromDate: fromDate.formatDateToString(), toDate: toDate.formatDateToString()) { resultApi in
          //  print("resultApi: ", resultApi)
            
            switch resultApi {
            case .onSuccess(let transactions):
                if let transactionsData = transactions {
                    switch tabType {
                    case .all:
                        self.allTransactions?.data += transactionsData.data
                        self.allTransactions?.paginate?.page = indexPage
                    case .purchase:
                        self.purchaseTransactions?.data += transactionsData.data
                        self.purchaseTransactions?.paginate?.page = indexPage
                    case .deposit:
                        self.depositTransactions?.data += transactionsData.data
                        self.depositTransactions?.paginate?.page = indexPage
                    case .service:
                        self.serviceTransactions?.data += transactionsData.data
                        self.serviceTransactions?.paginate?.page = indexPage
                    case .vending_machine:
                        self.vMachineTransactions?.data += transactionsData.data
                        self.vMachineTransactions?.paginate?.page = indexPage
                    case .tranfer_receive:
                        self.tranferTransactions?.data += transactionsData.data
                        self.tranferTransactions?.paginate?.page = indexPage
                    }
                }
                self.stateTransactions = .onSuccess(transactions)
            case .onError(let e):
                self.stateTransactions = .onError(e)
            }
        }
        
    }
    
    public func fetchDataWithTabType(tabType:TabTransactionType) async {
        
        stateTransactions = .onLoading
        
        TransactionsRepository.shared.fetchData(type: tabType,indexPage: 1, limitItem: limitItem, fromDate: fromDate.formatDateToString(), toDate: toDate.formatDateToString()) { resultApi in
          //  print("resultApi: ", resultApi)
            
            switch resultApi {
            case .onSuccess(let transactions):
                if let transactionsData = transactions {
                    switch tabType {
                    case .all:
                        self.allTransactions = transactionsData
                    case .purchase:
                        self.purchaseTransactions = transactionsData
                    case .deposit:
                        self.depositTransactions = transactionsData
                    case .service:
                        self.serviceTransactions = transactionsData
                    case .vending_machine:
                        self.vMachineTransactions = transactionsData
                    case .tranfer_receive:
                        self.tranferTransactions = transactionsData
                    }
                }
                self.stateTransactions = .onSuccess(transactions)
            case .onError(let e):
                self.stateTransactions = .onError(e)
            }
        }
    }
    
    private func getTransactionsWithTabType(tabType:TabTransactionType) -> Transactions?{
        
        switch tabType {
        case .all:
            self.allTransactions
        case .purchase:
            self.purchaseTransactions
        case .deposit:
            self.depositTransactions
        case .tranfer_receive:
            self.tranferTransactions
        case .service:
            self.serviceTransactions
        case .vending_machine:
            self.vMachineTransactions
        }
    }
}
