//
//  AuthenticateRepository.swift
//  UniService
//
//  Created by Admin on 24/01/2024.
//

import Foundation
import ObjectMapper

enum AuthenticateBody {
    case email
    case password
    
    var key:String {
        switch self {
        case .email:
            return "email"
        case .password:
            return "password"
        }
    }
}

class AuthenticateRepository: NSObject {
    static let shared = AuthenticateRepository()
    
    func login(email:String, password:String ,result:@escaping (_ result:ResultApi<Authenticate, AppException>)->Void){
        
        let dicParameters:NSMutableDictionary  = NSMutableDictionary()
        dicParameters.setValue( email as AnyObject, forKey: AuthenticateBody.email.key)
        dicParameters.setValue( password as AnyObject, forKey: AuthenticateBody.password.key)
        
        ApiService.shared.callAPIUnAuthenticate(url: ApiUrl.login, typeMethod: .post, dicParameters as? [String : Any]) { dataDict, isSusscess, statusCode, appException in
            
            if isSusscess, let data = dataDict as? [String:Any] {
                let authenticate = Mapper<Authenticate>().map(JSON: data)
                result(.onSuccess(authenticate))
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
