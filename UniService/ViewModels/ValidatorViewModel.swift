//
//  ValidatorViewModel.swift
//  UniService
//
//  Created by Admin on 19/01/2024.
//

import Foundation
import Combine

final class ValidatorViewModel: ObservableObject {
    
      @Published var validMess = ""
    
    func checkEmail(value:String){
       
        if value.isEmpty {
            validMess = "email can not be empty"
        }
        else{
            
            validMess = "invalid_email_address".localized()
        }
    }
}

