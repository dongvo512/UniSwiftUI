//
//  UserViewModel.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import Foundation
import ObjectMapper

final class UserViewModels: ObservableObject {
    
    @Published var userInfo:UserInfo? = nil
    @Published var stateUserInfo:BaseState = .onIdle
    @Published var stateUserLogout:BaseState = .onIdle
    
    init() {
        if AuthService.shared.isLogged() {
            self.fetchUserInfo()
        }
    }
    
    func fetchUserInfo(){
        
        stateUserInfo = .onLoading
        
        UserInfoRepository.shared.fetchUserInfo { resultApi in
            
            switch resultApi {
            case .onSuccess(let userInfoData):
                if let userInfo = userInfoData {
                    self.userInfo = userInfo
                }
                self.stateUserInfo = .onSuccess(userInfoData)
            case .onError(let e):
                self.stateUserInfo = .onError(e)
            }
        }
    }
    
    func logout(){
        
        stateUserLogout = .onLoading
        
        UserInfoRepository.shared.logout { resultApi in
            
            switch resultApi {
            case .onSuccess(let isFinish):
                self.userInfo = nil
                self.stateUserLogout = .onSuccess(isFinish)
            case .onError(let e):
                self.stateUserLogout = .onError(e)
            }
        }
    }
}
