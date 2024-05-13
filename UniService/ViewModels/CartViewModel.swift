//
//  CartViewModel.swift
//  UniService
//
//  Created by Admin on 25/03/2024.
//

import Foundation
import ObjectMapper

@MainActor final class CartViewModel: ObservableObject {
    
    init(){
        Task{
           await self.fetchCart(isRefreshing: false)
        }
    }
    
    @Published var card:Cart?
    @Published var stateCart:BaseState = .onIdle
 
    func fetchCart(isRefreshing:Bool) async{
       
        if isRefreshing == true {
            stateCart = .onIdle
        }
        else{
            stateCart = .onLoading
        }
        
        CartRepository.shared.fetchCart { resultApi in
           
            switch resultApi {
            case .onSuccess(let cart):
                if let cartData = cart {
                    self.card = cartData
                }
                self.stateCart = .onSuccess(cart)
            case .onError(let e):
                self.stateCart = .onError(e)
            }
        }
    }
}
