//
//  TransactionsRepository.swift
//  UniService
//
//  Created by Admin on 27/02/2024.
//

import Foundation
import ObjectMapper

class TransactionsRepository: NSObject {
    
    static let shared = TransactionsRepository()
    
    func fetchData(type:TabTransactionType, indexPage:Int, limitItem:Int, fromDate:String, toDate:String,result:@escaping (_ result:ResultApi<Transactions, AppException>)->Void){
        
        var url:String = ""
       
        if type == .all {
            
            url = String(format: ApiUrl.transactions, indexPage, limitItem, fromDate, toDate)
        }
        else{
            url = String(format: ApiUrl.transaction_with_type, indexPage, limitItem, type.key, fromDate, toDate)
        }
        
        ApiService.shared.callAPI(url: url, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict as? [String: Any] {
                let transactions = Mapper<Transactions>().map(JSON: data)
                result(.onSuccess(transactions))
            }
            else{
                
                result(.onError(appExeption))
            }
        }
    }
}
