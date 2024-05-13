//
//  CartRepository.swift
//  UniService
//
//  Created by Admin on 25/03/2024.
//

import Foundation
import ObjectMapper

class CartRepository: NSObject {
    static let shared = CartRepository()
    
    func paymentOrder(cartID:String, result:@escaping (_ result:ResultApi<String, AppException>)->Void){
        
        let dicParameters:NSMutableDictionary  = NSMutableDictionary()
        dicParameters.setValue( cartID as AnyObject, forKey: "cartId")
        
        ApiService.shared.callAPI(url: ApiUrl.payemnt_order, typeMethod: .post, dicParameters as? [String : Any]) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let billID = dataDict as? String {
                result(.onSuccess(billID))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchCart(result:@escaping (_ result:ResultApi<Cart, AppException>)->Void){
    
        ApiService.shared.callAPI(url: ApiUrl.cart_normal, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict as? [String : Any], let cart = Mapper<Cart>().map(JSON: data)  {
                result(.onSuccess(cart))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
}
