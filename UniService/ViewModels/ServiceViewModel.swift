//
//  ServiceViewModel.swift
//  UniService
//
//  Created by Admin on 13/03/2024.
//

import Foundation

@MainActor final class ServiceViewModels: ObservableObject {
    
    init() {
        Task{
            await self.fetchData()
        }
    }
    
    @Published var services:[Service] = []
    @Published var numOfDummys:Int = 10
    @Published var stateServices:BaseState = .onIdle
    
    func fetchData() async{
        
        self.stateServices = .onLoading
        
        ServiceRepository.shared.fetchData { resultApi in
            
            switch resultApi {
            case .onSuccess(let services):
                if let servicesData = services {
                  
                    self.services = servicesData
                }
                self.stateServices = .onSuccess(services)
            case .onError(let e):
                self.stateServices = .onError(e)
            }
        }
    }
}
