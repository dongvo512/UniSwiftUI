//
//  BranchsRepository.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import Foundation
import ObjectMapper

class BranchsRepository: NSObject {
    static let shared = BranchsRepository()
    
    func fetchBranchs(result:@escaping (_ result:ResultApi<[Branch], AppException>)->Void){
        
        ApiService.shared.callAPI(url: ApiUrl.branchs, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let branchs = Mapper<Branch>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(branchs))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
}
