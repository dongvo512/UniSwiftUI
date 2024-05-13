//
//  AppToast.swift
//  UniService
//
//  Created by Admin on 13/03/2024.
//

import Foundation
import UIKit

enum ToastType {
    case done
    case error
    case custom(title:String, image:UIImage)
}

class AppToast {
    
    static func showToast(toastType:ToastType, mess:String, from:SPIndicatorPresentSide = .top){
        
        switch toastType {
        case .done:
            SPIndicator.present(title:"successful".localized(), message: mess, preset: .done, from: from)
        case .error:
            SPIndicator.present(title:"errors".localized(), message: mess, preset: .error, from: from)
        case .custom(let title, let image):
            SPIndicator.present(title:title, message: mess, preset: .custom(image), from: from)
        }
        
    }
}


