//
//  AlertApp.swift
//  UniService
//
//  Created by Admin on 13/03/2024.
//

import Foundation
import UIKit

class AppAlert{
    
    static func showAlertOKCancel(title:String, mess:String, style:UIAlertController.Style = .alert, titleButtonOK:String = "agree".localized(), titleButtonCancel:String = "cancel".localized(), onPressOK: @escaping (()->Void), onPressCancel: (() ->Void)? = nil){
        
        let alert = UIAlertController(title: title, message: mess, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: titleButtonOK, style: UIAlertAction.Style.default, handler: { _ in
            onPressOK()
        }))
        
        alert.addAction(UIAlertAction(title: titleButtonCancel, style: UIAlertAction.Style.cancel, handler: { _ in
            
            if let callbackCancell = onPressCancel {
                callbackCancell()
            }
        }))
        
        UIApplication.shared.firstKeyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertOK(title:String, mess:String, isNeverClose:Bool = false, style:UIAlertController.Style = .alert, onPressOK: @escaping (()->Void), titleButtonOK:String = "OK"){
        
        let alert = UIAlertController(title: title, message: mess, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: titleButtonOK, style: UIAlertAction.Style.default, handler: { _ in
            
            onPressOK()
            
            if isNeverClose {
                UIApplication.shared.firstKeyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }))
        
        UIApplication.shared.firstKeyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}


