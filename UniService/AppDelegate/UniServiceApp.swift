//
//  UniServiceApp.swift
//  UniService
//
//  Created by Admin on 09/01/2024.
//

import SwiftUI

@main
struct UniServiceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if LocaleStorageService.shared.getBranchCurr() != nil {
                MainPageView()
            }
            else{
                BranchsPageView()
            }
            
        }
    }
}
