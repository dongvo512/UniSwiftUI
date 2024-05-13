//
//  ServiceRepository.swift
//  UniService
//
//  Created by Admin on 13/03/2024.
//

import Foundation
import ObjectMapper

class ServiceRepository: NSObject {
   
    static let shared = ServiceRepository()
    
    func fetchData(result:@escaping (_ result:ResultApi<[Service], AppException>)->Void){
        
        ApiService.shared.callAPI(url: ApiUrl.services, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appExeption in
            
            if isSusscess, let data = dataDict {
                let services = Mapper<Service>().mapArray(JSONObject: data) ?? []
                result(.onSuccess(services))
            }
            else{
               
                result(.onError(appExeption))
            }
        }
    }
    
}
