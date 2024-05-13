//
//  UserInfoRepository.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import Foundation
import ObjectMapper

class UserInfoRepository: NSObject {
    static let shared = UserInfoRepository()
    
    func fetchUserInfo(result:@escaping (_ resultApi:ResultApi<UserInfo, AppException>)->Void){
        
        ApiService.shared.callAPI(url: ApiUrl.user_info, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appException in
            
            if isSusscess, let data = dataDict as? [String:AnyObject] {
                if let user_info = Mapper<UserInfo>().map(JSON: data) {
                    result(.onSuccess(user_info))
                }
                else{
                    
                    result(.onError(appException))
                }
            }
        }
    }
    
    func logout(result:@escaping (_ resultApi:ResultApi<Bool,AppException>)->Void){
        
        ApiService.shared.callAPI(url: ApiUrl.logout, typeMethod: .get, nil) { dataDict, isSusscess, statusCode, appException in
            
            if isSusscess {
                result(.onSuccess(true))
                ApiService.shared.clearAuthenticate()
            }
            else{
                
                result(.onError(appException))
                
                if let exception = appException {
                    AppToast.showToast(toastType: .error, mess: exception.getErrorMess())
                }
            }
        }
    }
}
