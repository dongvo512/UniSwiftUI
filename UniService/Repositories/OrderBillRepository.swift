//
//  OrderBillRepository.swift
//  UniService
//
//  Created by Admin on 18/03/2024.
//

import Foundation
import ObjectMapper

class OrderBillRepository: NSObject {
    
    static let shared = OrderBillRepository()
    
    func getOrderBillDetail(idBill:String, result:@escaping (_ result:ResultApi<ProductBill, AppException>)->Void){
        
        ApiService.shared.callAPI(url: String(format: ApiUrl.order_bill_detail, idBill), typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict as? [String:Any] {
                let bill = Mapper<ProductBill>().map(JSON: data)
                result(.onSuccess(bill))
            }
            else{
                
                result(.onError(appExeption))
            }
        }
    }
}
