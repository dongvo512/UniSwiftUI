//
//  AuthenticateViewModel.swift
//  UniService
//
//  Created by Admin on 24/01/2024.
//

import Foundation
import Combine

final class AuthenticateViewModel: ObservableObject {
    
    @Published var authenticate:Authenticate? = nil
   // @Published var stateAuthenticate:BaseState = .onIdle
    
    func login(email:String, password:String, onLoading:(() ->Void)? = nil,onSuccess: ((_ auth:Authenticate) -> Void)? = nil, onError:((AppException?) -> Void)? = nil){
        
       // stateAuthenticate = .onLoading
        onLoading?()
        
        AuthenticateRepository.shared.login(email: email, password: password) { resultApi in
            
            switch resultApi {
            case .onSuccess(let authOjb):
                if let auth = authOjb{
                    self.authenticate = auth
                    onSuccess?(auth)
                }
               // self.stateAuthenticate = .onSuccess(authOjb)
            case .onError(let e):
                onError?(e);
                //self.stateAuthenticate = .onFailed(e)
            }
        }
    }
}
