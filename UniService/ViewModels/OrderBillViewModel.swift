//
//  OrderBillViewModel.swift
//  UniService
//
//  Created by Admin on 18/03/2024.
//

import Foundation
import ObjectMapper


@MainActor final class OrderBillViewModel: ObservableObject  {
  
    @Published var bill:ProductBill?
    @Published var stateOrderBill:BaseState = .onIdle
    
    func getOrderBillDetail(idBill:String ,isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateOrderBill = .onIdle
        }
        else{
            stateOrderBill = .onLoading
        }
        
        OrderBillRepository.shared.getOrderBillDetail(idBill: idBill, result: { resultApi in
            
            switch resultApi {
            case .onSuccess(let bill):
                if let data = bill {
                    self.bill = data
                }
                self.stateOrderBill = .onSuccess(bill)
            case .onError(let e):
                self.stateOrderBill = .onError(e)
            }
        })
    }
    
}
