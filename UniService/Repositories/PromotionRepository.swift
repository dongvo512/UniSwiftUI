//
//  PromotionRepository.swift
//  UniService
//
//  Created by Admin on 18/01/2024.
//

import Foundation
import ObjectMapper

class PromotionRepository: NSObject {
    static let shared = PromotionRepository()
    
    func fetchPromotions(result:@escaping (_ result:ResultApi<[Promotion], AppException>)->Void){
        
        ApiService.shared.callAPI(url: ApiUrl.promotions, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let promotions = Mapper<Promotion>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(promotions))
            }
            else{
                
                result(.onError(appExeption))
            }
        }
    }
}
