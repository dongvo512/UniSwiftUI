//
//  Permission.swift
//  UniService
//
//  Created by Admin on 10/5/24.
//

import Foundation
import UIKit
import AVFoundation

class PermissionService: NSObject {
    
    enum PermissionType {
        case authorized
        case rejected
        case nosupport
    }
    
    static func checkPermissionCamera(result:@escaping (_ type:PermissionType) -> Void){
        
        //Camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
                result(.authorized)
                
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        // User granted
                        result(.authorized)
                        
                    } else {
                        // User rejected
                        result(.rejected)
                        
                        DispatchQueue.main.async {
                            
                            AppAlert.showAlertOKCancel(title: S.empty, mess: "allow_setting_camear".localized(),titleButtonOK:"go_to_setting".localized()) {
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                        print("Settings opened: \(success)") // Prints true
                                    })
                                }
                            }
                            
                        }
                    }
                })
            }
        }
        else{
            
            result(.nosupport)
            
            DispatchQueue.main.async {
                
                AppAlert.showAlertOK(title: S.empty, mess: "camera_not_support".localized()) {
                    
                }
            }
        }
    }
}
