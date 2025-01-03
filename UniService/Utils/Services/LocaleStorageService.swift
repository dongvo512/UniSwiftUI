//
//  LocaleStorageService.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation

struct StorageKey {
    static let kLanguageKey = "language_key"
    static let kAccessToken = "access_token_key"
    static let kRefreshToken = "refresh_token_key"
    static let kUpdatedRefreshTokenAt = "update_refresh_token_key_at"
    static let kExpiredRefreshTokenIn = "expired_refresh_token_key_in"
    static let kPinCode = "pin_code_key"
    static let kBranchSelected = "branch_selected"
}

class LocaleStorageService {
    
    static let shared = LocaleStorageService()
    
    // - Language
    func saveLanguageCurr(language:String?){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(language, forKey: StorageKey.kLanguageKey)
        userDefaults.synchronize()
    }
    
    func getLanguageCurr() -> String?{
       
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: StorageKey.kLanguageKey) as? String
    }
    
    // - Access Token
    func isHaveAccessToken() -> Bool {
        
        if self.getAccessTokenCurr() != nil {
            return true
        }
        else{
            return false
        }
    }
    
    func removeAccessToken(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: StorageKey.kAccessToken)
        userDefaults.synchronize()
    }
    
    func saveAccessTokenCurr(access_token:String?){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(access_token, forKey: StorageKey.kAccessToken)
        userDefaults.synchronize()
    }
    
    func getAccessTokenCurr() -> String?{
       
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.object(forKey: StorageKey.kAccessToken) as? String
        print("AccessToken: ", accessToken ?? "Empty")
        return accessToken
    }
    
    // - Refresh Token
    func saveRefreshTokenCurr(refreshToken:String?){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(refreshToken, forKey: StorageKey.kRefreshToken)
        userDefaults.synchronize()
    }
    
    func removeRefreshToken(){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: StorageKey.kRefreshToken)
        userDefaults.synchronize()
    }
    
    func getRefreshTokenCurr() -> String?{
       
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: StorageKey.kRefreshToken) as? String
    }
    
    func saveExpiresInCurr(expires_inCurr:Int?){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(expires_inCurr, forKey: StorageKey.kExpiredRefreshTokenIn)
        userDefaults.synchronize()
    }
    
    func removeExpiresInCurr(){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: StorageKey.kExpiredRefreshTokenIn)
        userDefaults.synchronize()
    }
    
    func getExpiresInCurr() -> Int?{
       
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: StorageKey.kExpiredRefreshTokenIn) as? Int
    }
    
    // MARK - PIN Code
    
    func removePINCode(){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: StorageKey.kPinCode)
        userDefaults.synchronize()
    }
    
    func savePINCode(pinCode:String?){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(pinCode, forKey: StorageKey.kPinCode)
        userDefaults.synchronize()
    }
    
    func getPINCode() -> String?{
       
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: StorageKey.kPinCode) as? String
    }
    
    // MARK - Branch
    func removeBranchSelected(){
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: StorageKey.kBranchSelected)
        userDefaults.synchronize()
    }
    
    func saveBranchCurr(branch:Branch?){
        
        do {
            let encoder = JSONEncoder()

               // Encode Note
               let data = try encoder.encode(branch)

               // Write/Set Data
               UserDefaults.standard.set(data, forKey: StorageKey.kBranchSelected)

        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    
    func getBranchCurr() -> Branch?{
       
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.object(forKey: StorageKey.kBranchSelected) as? Data {
         
            let decode = JSONDecoder()
            let branch = try? decode.decode(Branch.self, from: data)
            return branch
        }
        else{
            
            return nil
        }
    }
}



