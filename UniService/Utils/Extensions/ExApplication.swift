//
//  ExApplication.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation
import UIKit

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        // 1
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        // 2
        let activeScene = windowScenes
            .filter { $0.activationState == .foregroundActive }
        // 3
        let firstActiveScene = activeScene.first
        // 4
        let keyWindow = firstActiveScene?.keyWindow
        
        return keyWindow
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
