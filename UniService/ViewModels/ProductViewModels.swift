//
//  ProductViewModels.swift
//  UniService
//
//  Created by Admin on 11/01/2024.
//

import Foundation
import ObjectMapper

enum BaseState {
    case onIdle
    case onLoading
    case onSuccess(Any?)
    case onError(AppException?)
}

@MainActor final class ProductViewModels: ObservableObject {
    
    init(){
        Task{
           await self.fetchAllMenu(isRefreshing: false)
        }
    }
    
    @Published var idBill:String?
    
    @Published var orderedProduct:Product?
    @Published var selectedProduct:Product?
    @Published var quantity:Int = 1
    
    @Published var numOfDummys:Int = 3
    
    // Today
    @Published var menuTodays:[Product] = []
    @Published var stateMenuToday:BaseState = .onIdle
    
    // Drinks
    @Published var menuDrinks:[Product] = []
    @Published var stateMenuDrinks:BaseState = .onIdle
    
    // FoodCourt
    @Published var menuFoodCourt:[Product] = []
    @Published var stateMenuFoodCourt:BaseState = .onIdle
    
    // SpecicalFood
    @Published var menuSpecicalFood:[Product] = []
    @Published var stateMenuSpecicalFood:BaseState = .onIdle
    
    // Neccessary
    @Published var menuNeccessary:[Product] = []
    @Published var stateMenuNeccessary:BaseState = .onIdle
    
    @Published var stateAddProduct:BaseState = .onIdle
    
    func fetchAllMenu(isRefreshing:Bool) async {
        await self.fetchMenuToday(isRefreshing: isRefreshing)
        await self.fetchMenuDrinks(isRefreshing: isRefreshing)
        await self.fetchMenuFoodCourt(isRefreshing: isRefreshing)
        await self.fetchMenuSpecicalFood(isRefreshing: isRefreshing)
        await self.fetchMenuNeccessary(isRefreshing: isRefreshing)
    }
    
    
    func addOrderedCart(product:Product, completed:@escaping (_ result:Bool)->Void){
       
        stateAddProduct = .onLoading
        
        ProductRepository.shared.addOrderToCart(product: product) { resultApi in
            
            switch resultApi {
            case .onSuccess(let isSuccess):
                self.stateAddProduct = .onSuccess(isSuccess)
                completed(true)
            case .onError(let e):
                self.stateAddProduct = .onError(e)
                completed(false)
            }
        }
    }
    
    func fetchMenuToday(isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateMenuToday = .onIdle
        }
        else{
            stateMenuToday = .onLoading
        }
        
        ProductRepository.shared.fetchMenuToday { resultApi in
            
            switch resultApi {
            case .onSuccess(let products):
                if let productsData = products {
                    self.menuTodays = productsData
                }
                self.stateMenuToday = .onSuccess(products)
            case .onError(let e):
                self.stateMenuToday = .onError(e)
            }
        }
    }
    
    func fetchMenuDrinks(isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateMenuDrinks = .onIdle
        }
        else{
            stateMenuDrinks = .onLoading
        }
        
        ProductRepository.shared.fetchMenuDrinks { resultApi in
            
            switch resultApi {
            case .onSuccess(let products):
                if let productsData = products {
                    self.menuDrinks = productsData
                }
                self.stateMenuDrinks = .onSuccess(products)
            case .onError(let e):
                self.stateMenuDrinks = .onError(e)
            }
        }
    }
    
    func fetchMenuFoodCourt(isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateMenuFoodCourt = .onIdle
        }
        else{
            stateMenuFoodCourt = .onLoading
        }
        
         ProductRepository.shared.fetchMenuFoodCourt { resultApi  in
        
            switch resultApi {
            case .onSuccess(let products):
                if let productsData = products {
                    self.menuFoodCourt = productsData
                }
                self.stateMenuFoodCourt = .onSuccess(products)
            case .onError(let e):
                self.stateMenuFoodCourt = .onError(e)
            }
        }
    }
    
    func fetchMenuSpecicalFood(isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateMenuSpecicalFood = .onIdle
        }
        else{
            stateMenuSpecicalFood = .onLoading
        }
        
        ProductRepository.shared.fetchMenuSpecicalFood { resultApi  in
            
            switch resultApi {
            case .onSuccess(let products):
                if let productsData = products {
                    self.menuSpecicalFood = productsData
                }
                self.stateMenuSpecicalFood = .onSuccess(products)
            case .onError(let e):
                self.stateMenuSpecicalFood = .onError(e)
            }
        }
    }
    
    func fetchOrderedProduct(){
        
        
    }
    
    func fetchMenuNeccessary(isRefreshing:Bool) async{
        
        if isRefreshing == true {
            stateMenuNeccessary = .onIdle
        }
        else{
            stateMenuNeccessary = .onLoading
        }
        
        ProductRepository.shared.fetchMenuNeccessary { resultApi in
            
            switch resultApi {
            case .onSuccess(let products):
                if let productsData = products {
                    self.menuNeccessary = productsData
                }
                self.stateMenuNeccessary = .onSuccess(products)
            case .onError(let e):
                self.stateMenuNeccessary = .onError(e)
            }
        }
    }
}
