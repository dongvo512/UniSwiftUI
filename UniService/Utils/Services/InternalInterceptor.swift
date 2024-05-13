//
//  PiHomeInterceptor.swift
//  PiHome
//
//  Created by Dong vo on 13/09/2021.
//

import UIKit
import Alamofire

class InternalInterceptor: RequestInterceptor {
    
    typealias AdapterResult<T> = Result<T, Error>
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AdapterResult<URLRequest>) -> Void) {
        print("ADAPT :=")
        
        var urlRequest = urlRequest
        
        if let accessToken = LocaleStorageService.shared.getAccessTokenCurr() {
            
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        let response = request.task?.response as? HTTPURLResponse
        
        if let statusCode = response?.statusCode {
            
            //  print("Retry url:", request.)
            
            if statusCode == StatusCode.CODE_EXPIRED_AUTH {
                
                LogService.shared.printLog(title: "Error", value: request.request?.url as Any)
                LogService.shared.printLog(title: "AccessToken", value: LocaleStorageService.shared.getAccessTokenCurr() as Any)
                
                if ApiService.shared.isRefreshing == false && self.checkTimeRefresh() == true{
                    
                    ApiService.shared.expires_in = 0
                    
                    ApiService.shared.callRefreshToken { isFinish in
                        
                        if isFinish {
                            
                            completion(.retry)
                        }
                        else{
                            
                            completion(.doNotRetry)
                        }
                    }
                }
                else{
                    
                    if ApiService.shared.refreshToken != nil {
                        
                        completion(.retryWithDelay(0.1))
                    }
                    else{
                        
                        completion(.doNotRetry)
                    }
                }
            }
            else{
                
                return completion(.doNotRetry)
            }
            
        } else {
            return completion(.doNotRetry)
        }
        
    }
    
    private func checkTimeRefresh() -> Bool {
        
        if let rf_update_at = ApiService.shared.refreshToken_Update_At, let expires_time = ApiService.shared.expires_in {
            
            var second:TimeInterval = 0
            
            if #available(iOS 13.0, *) {
                second = rf_update_at.distance(to: Date())
            } else {
                // Fallback on earlier versions
                second = Date().timeIntervalSince(rf_update_at)
            }
            
            if second < TimeInterval(expires_time) {
            
                return false
            }
            else{
                return true
            }
        }
        else{
            
            return true
        }
    }
}
