//
//  PromotionViewModel.swift
//  UniService
//
//  Created by Admin on 18/01/2024.
//

import Foundation

@MainActor final class PromotionViewModel: ObservableObject {
    
    @Published var promotions:[Promotion] = []
    @Published var statePromotions:BaseState = .onIdle
    
    init() {
        Task{
          await self.fetchPromotions()
        }
    }
    
    func fetchPromotions() async{
        
        statePromotions = .onLoading
        
        PromotionRepository.shared.fetchPromotions { resultApi in
            
            switch resultApi {
            case .onSuccess(let promotions):
                if let promotionsData = promotions {
                    self.promotions = promotionsData
                }
                self.statePromotions = .onSuccess(promotions)
            case .onError(let e):
                self.statePromotions = .onError(e)
            }
        }
    }
}
