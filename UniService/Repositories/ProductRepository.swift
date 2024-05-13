//
//  ProductRepository.swift
//  UniService
//
//  Created by Admin on 11/01/2024.
//

import Foundation
import ObjectMapper

enum ResultApi<T,E> {
    case onSuccess(T?)
    case onError(E?)
}

class ProductRepository: NSObject {
    static let shared = ProductRepository()
    
    func addOrderToCart(product:Product, result:@escaping (_ result:ResultApi<Bool, AppException>)->Void){
        
        let dicParameters = NSMutableDictionary()
        
        if let itemSelected = product.itemSelected {
            
            dicParameters.setValue(itemSelected.id, forKey: "idProduct")
        }
        else{
            
            if let id = product.id {
                
                dicParameters.setValue(id, forKey: "idProduct")
            }
        }
        
        dicParameters.setValue(product.selectedQuantity, forKey: "quantity")
        
        ApiService.shared.callAPI(url: ApiUrl.add_product_to_cart, typeMethod: .post, dicParameters as? [String : Any]) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess{
                result(.onSuccess(isSusscess))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchMenuToday(result:@escaping (_ result:ResultApi<[Product], AppException>)->Void){
        
        var branchID:String = ""
        
        if let branch = LocaleStorageService.shared.getBranchCurr() {
            branchID = "&branchId=" + (branch.id ?? S.empty)
        }
        
        ApiService.shared.callAPI(url: ApiUrl.menu_today + branchID, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let products = Mapper<Product>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(products))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchMenuDrinks(result:@escaping (_ result:ResultApi<[Product], AppException>)->Void){
        
        var branchID:String = ""
        
        if let branch = LocaleStorageService.shared.getBranchCurr() {
            branchID = "&branchId=" + (branch.id ?? S.empty)
        }
        
        ApiService.shared.callAPI(url: ApiUrl.menu_drinks + branchID, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let products = Mapper<Product>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(products))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchMenuFoodCourt(result:@escaping (_ result:ResultApi<[Product], AppException>)->Void){
        
        var branchID:String = ""
        
        if let branch = LocaleStorageService.shared.getBranchCurr() {
            branchID = "&branchId=" + (branch.id ?? S.empty)
        }
        
        ApiService.shared.callAPI(url: ApiUrl.menu_foodcourt + branchID, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let products = Mapper<Product>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(products))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchMenuSpecicalFood(result:@escaping (_ result:ResultApi<[Product], AppException>)->Void){
        
        var branchID:String = ""
        
        if let branch = LocaleStorageService.shared.getBranchCurr() {
            branchID = "&branchId=" + (branch.id ?? S.empty)
        }
        
        ApiService.shared.callAPI(url: ApiUrl.menu_specical_food + branchID, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let products = Mapper<Product>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(products))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
    func fetchMenuNeccessary(result:@escaping (_ result:ResultApi<[Product], AppException>)->Void){
        
        var branchID:String = ""
        
        if let branch = LocaleStorageService.shared.getBranchCurr() {
            branchID = "&branchId=" + (branch.id ?? S.empty)
        }
        
        ApiService.shared.callAPI(url: ApiUrl.menu_neccessary + branchID, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let products = Mapper<Product>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(products))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
}
