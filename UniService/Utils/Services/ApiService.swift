//
//  ApiService.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation
import Alamofire
import ObjectMapper
import UIKit

struct AppException {
    var statusCode:Int?
    var errorMess:String?
    var errorValidate:[ValidResult]?
    
    func getErrorMess() -> String{
        
        if let validates = self.errorValidate, validates.count > 0 {
            return validates.first?.message ?? S.empty
        }
        else if let mess = self.errorMess{
            return mess
        }
        else{
            return "unknown_error".localized()
        }
    }
}

class ApiService:NSObject{
    static let shared = ApiService()
    
    var isRefreshing:Bool = false
    var accessToken:String? = nil
    var refreshToken:String? = nil
    var refreshToken_Update_At:Date? = nil
    var expires_in:Int? = nil
    
    var interactor:RequestInterceptor = InternalInterceptor()
    var listAcceptStatusCode:Array = Array(                                           arrayLiteral: StatusCode.CODE_SUCCESS,
                                                                                      StatusCode.CODE_SUCCESS_2,
                                                                                      StatusCode.CODE_VALIDATE_DATA,
                                                                                      StatusCode.CODE_BAD_REQUEST_DATA,StatusCode.CODE_FORBIDDEN,StatusCode.CODE_ERROR_DATA,StatusCode.CODE_PAYMENT_FAIL_2,StatusCode.CODE_PAYMENT_FAIL,StatusCode.CODE_OTP_DELAYING, StatusCode.CODE_ADD_MORE_INFO,StatusCode.CODE_BRANCH_INVALID)
    
    
    
    func callAPI(
        isReCall:Bool = true,
        url:String,
        typeMethod:HTTPMethod ,
        _ parameters:[String:Any]?,
        success:@escaping (_ dataDict:Any?, _ isSusscess:Bool,_ statusCode:Int,_ appException:AppException?)->Void){
            
            if (isReCall){
                let satus = NetworkManager.sharedInstance.reachability.connection
                
                if satus == .unavailable {
                    
                    NetworkManager.statusChange { (complete) in
                        
                        let newStatus = NetworkManager.sharedInstance.reachability.connection
                        
                        if(newStatus == .unavailable){
                            AppToast.showToast(toastType: .error, mess: "internet_error".localized(), from: .top)
                        }
                        else {
                            
                            self.callAPI(url: url, typeMethod: typeMethod, parameters, success: success)
                        }
                    }
                }
            }
            
            
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            var headers: HTTPHeaders = [
                "App-Os": "ios",
                "App-Version": version,
                "Accept": "application/json",
                "Content-Type":"application/json",
                "language":LanguageService.shared.currentLanguage
            ]
            
            var token = ""
            if let accessToken = LocaleStorageService.shared.getAccessTokenCurr() {
                
                token = String(format: "Bearer %@", accessToken)
                headers.add(name: "Authorization", value: token)
                
            }
            
            let fullUrl = AppEnviroment.baseURL  + url
            
            let endCodeURL = fullUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            let urlFull = URL(string: endCodeURL!)
            
            guard urlFull != nil else {
                return
            }
            
            
            AF.request(urlFull!, method: typeMethod, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers, interceptor: self.interactor).validate(statusCode: listAcceptStatusCode).responseData{ response in
                
                if let statusCode = response.response?.statusCode {
                    
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            if let result = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject]{
                                
                                LogService.shared.printLog(title: "Result JSON", value: result,url: fullUrl)
                                
                                self.checkSettingRespone(result: result)
                                
                                if statusCode == StatusCode.CODE_SUCCESS || statusCode == StatusCode.CODE_SUCCESS_2 {
                                    
                                    if let dataResponse = result["data"]{
                                        
                                        success(dataResponse,true,statusCode, nil)
                                    }
                                    else{
                                        
                                        success(result,true,statusCode, nil)
                                    }
                                }
                                else if statusCode == StatusCode.CODE_VALIDATE_DATA || statusCode == StatusCode.CODE_ERROR_DATA || statusCode == StatusCode.CODE_BAD_REQUEST_DATA || statusCode == StatusCode.CODE_PAYMENT_FAIL || statusCode == StatusCode.CODE_PAYMENT_FAIL_2 || statusCode == StatusCode.CODE_BRANCH_INVALID{
                                    
                                    let arrayValidate = Mapper<ValidResult>().mapArray(JSONObject: result["errors"]) ?? []
                                    
                                    var errorMess:String? = nil
                                    
                                    if let message:String = (result["message"]) as? String {
                                        errorMess = message
                                    }
                                    
                                    if(arrayValidate.count > 0){
                                        
                                        success(arrayValidate as AnyObject ,false,statusCode,AppException(statusCode: statusCode, errorMess:errorMess, errorValidate: arrayValidate))
                                    }
                                    else{
                                        
                                        success(nil ,false,statusCode, AppException(statusCode: statusCode, errorMess:errorMess))
                                    }
                                }
                                else{
                                    
                                    success(result as AnyObject ,false,statusCode,AppException(statusCode: statusCode))
                                }
                            }
                        } catch {
                            LogService.shared.printLog(title: "Error", value: "response Api Error",url: fullUrl)
                        }
                    case .failure(let error):
                        success(nil ,false,StatusCode.CODE_ERROR,AppException(statusCode:StatusCode.CODE_ERROR, errorMess: error.localizedDescription))
                        
                        LogService.shared.printLog(title: "Error", value: error.localizedDescription, url:fullUrl)
                        
                    }
                }
            }
        }
    
    func callAPIUnAuthenticate(
        url:String,
        typeMethod:HTTPMethod ,
        _ parameters:[String:Any]?,
        success:@escaping (_ dataDict:Any?, _ isSusscess:Bool,_ statusCode:Int,_ appException:AppException?)->Void){
            
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            var headers: HTTPHeaders = [
                "App-Os": "ios",
                "App-Version": version,
                "Accept": "application/json",
                "Content-Type":"application/json",
                "language":LanguageService.shared.currentLanguage
            ]
            
            var token = ""
            if let accessToken = LocaleStorageService.shared.getAccessTokenCurr() {
                
                token = String(format: "Bearer %@", accessToken)
                headers.add(name: "Authorization", value: token)
                
            }
            
            let fullUrl = AppEnviroment.baseURL  + url
            
            let endCodeURL = fullUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            let urlFull = URL(string: endCodeURL!)
            
            guard urlFull != nil else {
                return
            }
            
            
            AF.request(urlFull!, method: typeMethod, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: headers).responseData{ response in
                
                if let statusCode = response.response?.statusCode {
                    
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            if let result = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject]{
                                
                                LogService.shared.printLog(title: "Result JSON", value: result,url: fullUrl)
                                
                                self.checkSettingRespone(result: result)
                                
                                if statusCode == StatusCode.CODE_SUCCESS || statusCode == StatusCode.CODE_SUCCESS_2 {
                                    
                                    if let dataResponse = result["data"]{
                                        
                                        success(dataResponse,true,statusCode, nil)
                                    }
                                    else{
                                        
                                        success(result,true,statusCode, nil)
                                    }
                                }
                                else if statusCode == StatusCode.CODE_VALIDATE_DATA || statusCode == StatusCode.CODE_ERROR_DATA || statusCode == StatusCode.CODE_BAD_REQUEST_DATA || statusCode == StatusCode.CODE_PAYMENT_FAIL || statusCode == StatusCode.CODE_PAYMENT_FAIL_2 || statusCode == StatusCode.CODE_BRANCH_INVALID || statusCode == StatusCode.CODE_EXPIRED_AUTH{
                                    
                                    let arrayValidate = Mapper<ValidResult>().mapArray(JSONObject: result["errors"]) ?? []
                                    
                                    var errorMess:String? = nil
                                    
                                    if let message:String = (result["message"]) as? String {
                                        errorMess = message
                                    }
                                    
                                    if(arrayValidate.count > 0){
                                        
                                        success(arrayValidate as AnyObject ,false,statusCode,AppException(statusCode: statusCode, errorMess:errorMess, errorValidate: arrayValidate))
                                    }
                                    else{
                                        
                                        success(nil ,false,statusCode, AppException(statusCode: statusCode, errorMess:errorMess))
                                    }
                                }
                                else{
                                    
                                    success(result as AnyObject ,false,statusCode,AppException(statusCode: statusCode))
                                }
                            }
                        } catch {
                            LogService.shared.printLog(title: "Error", value: "response Api Error",url: fullUrl)
                        }
                    case .failure(let error):
                        success(nil ,false,StatusCode.CODE_ERROR,AppException(statusCode:StatusCode.CODE_ERROR, errorMess: error.localizedDescription))
                        
                        LogService.shared.printLog(title: "Error", value: error.localizedDescription, url:fullUrl)
                        
                    }
                }
            }
        }
    
    
    func callRefreshToken(isFinish:@escaping (_ isFinish:Bool)->Void){
        
        guard self.refreshToken != nil else {
            isFinish(false)
            return
        }
        
        let fullUrl = AppEnviroment.baseURL  + ApiUrl.new_access_token
        
        let endCodeURL = fullUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = URL(string: endCodeURL!)
        
        guard url != nil else {
            return
        }
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        var headers: HTTPHeaders = [
            "App-Os": "ios",
            "App-Version": version,
            "Accept": "application/json",
            "Content-Type":"application/json",
            "language":LanguageService.shared.currentLanguage,
            
        ]
        
        var token = ""
        if let accessToken = self.refreshToken {
            
            token = String(format: "Bearer %@", accessToken)
            headers.add(name: "Authorization", value: token)
            LogService.shared.printLog(title: "Refresh Token Called", value: token, url:fullUrl)
        }
        
        isRefreshing = true
        
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers).responseData { response in
            
            if let statusCode = response.response?.statusCode {
                
                switch response.result {
                case .success(let data):
                    do {
                        if let result = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject]{
                            
                            if(statusCode == StatusCode.CODE_SUCCESS || statusCode == StatusCode.CODE_SUCCESS_2){
                                
                                self.isRefreshing = false
                                
                                if let dataResponse = result["data"] as? [String : Any] {
                                    
                                    if let refreshTokenModel = Mapper<RefreshTokenModel>().map(JSON: dataResponse) {
                                        
                                        self.saveRefreshToken(refreshTokenModel: refreshTokenModel)
                                        isFinish(true)
                                        
                                    }
                                    else{
                                        self.clearAuthenticate()
                                        isFinish(false)
                                    }
                                }
                                else{
                                    self.clearAuthenticate()
                                    isFinish(false)
                                    //AppDirectionHandler.shared.backToRootAndClearAuthen()
                                }
                            }
                            else{
                                
                                self.clearAuthenticate()
                                
                                isFinish(false)
                                
                                //                                if let message:String = (result["message"] as? String) {
                                //
                                //                                   // let errorMess = message
                                //
                                //                                  //  SPIndicator.present(title:"", message: errorMess, preset: .error)
                                //                                }
                                
                                //  AppDirectionHandler.shared.backToRootAndClearAuthen()
                            }
                        }
                    } catch {
                        
                        LogService.shared.printLog(title: "Error", value: data , url:fullUrl)
                    }
                case .failure(let error):
                    LogService.shared.printLog(title: "Error", value: error.localizedDescription, url:fullUrl)
                    self.isRefreshing = false
                    // self.clearAuthenticate()
                    //  AppDirectionHandler.shared.backToRootAndClearAuthen()
                    // print("Fail: ", error.localizedDescription)
                    
                }
            }
        }
    }
    
    private func saveRefreshToken(refreshTokenModel:RefreshTokenModel){
        
        self.accessToken = refreshTokenModel.access_token
        self.refreshToken = refreshTokenModel.refresh_token
        self.expires_in = refreshTokenModel.expires_in
        self.refreshToken_Update_At = Date()
        LocaleStorageService.shared.saveRefreshTokenCurr(refreshToken: refreshToken)
    }
    
    func clearAuthenticate(){
        
        self.accessToken = nil
        self.refreshToken = nil
        self.expires_in = 0
        self.isRefreshing = false
        
        LocaleStorageService.shared.removeAccessToken()
        LocaleStorageService.shared.removeRefreshToken()
        LocaleStorageService.shared.removeExpiresInCurr()
        LocaleStorageService.shared.savePINCode(pinCode: nil)
        
        // NotificationCenter.default.post(name: Notification.Name.RefreshData , object: nil)
    }
    
    private func checkSettingRespone(result:[String:AnyObject]){
        
        if let settingResponse = result["settings"], let appVersion = settingResponse["iosAppVersion"] as? String {
            
            if let versionApp = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                
                if versionApp.versionCompare(appVersion) == .orderedAscending {
                    
                    AppAlert.showAlertOK(title: "title_new_version".localized(), mess: "move_to_appstore".localized(), isNeverClose:true) {
                        
                        if let url = URL(string: S.app_store_link) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
    }
}
