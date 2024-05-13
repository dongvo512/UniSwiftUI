//
//  NetworkManager.swift
//  MotoCafeClient
//
//  Created by Dong vo on 5/8/19.
//  Copyright © 2019 Vietlink. All rights reserved.
//

import UIKit
import Foundation
import Reachability

class NetworkManager: NSObject {
 
    var reachability: Reachability!
   
    static let sharedInstance: NetworkManager = { return NetworkManager() }()
  
    var completionHandler: ((NetworkManager) -> Void)? = nil
    
    override init() {
        super.init()
        
        // Initialise reachability
        do {
             
             reachability = try Reachability()
             
             // Register an observer for the network status
             NotificationCenter.default.addObserver(
                 self,
                 selector: #selector(networkStatusChanged(_:)),
                 name: .reachabilityChanged,
                 object: reachability
             )
             
             do {
                 // Start the network status notifier
                 try reachability.startNotifier()
             } catch {
                 print("Unable to start notifier")
             }
             
         } catch {
             
             print("Unable to init reachability")
         }
        
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        
        let network = NetworkManager.sharedInstance
        
        if(network.completionHandler != nil){
            
             network.completionHandler!(NetworkManager.sharedInstance)
        }
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    
    static func statusChange (completed:  @escaping (NetworkManager) -> Void) {
       let network = NetworkManager.sharedInstance
        network.completionHandler = completed
    }
    
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
}
