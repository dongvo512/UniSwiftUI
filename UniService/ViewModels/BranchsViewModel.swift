//
//  BranchsViewModel.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import Foundation

final class BranchsViewModel: ObservableObject {
    
    @Published var branchs:[Branch] = []
    @Published var stateBranchs:BaseState = .onIdle
    
    init() {
        fetchBranchs()
    }
    
    func fetchBranchs(){
        self.stateBranchs = .onLoading
        BranchsRepository.shared.fetchBranchs { result in
            
            switch result {
            case .onSuccess(let branchs):
                if let branchsData = branchs {
                    self.branchs = branchsData
                }
                self.stateBranchs = .onSuccess(branchs)
            case .onError(let e):
                self.stateBranchs = .onError(e)
            }
        }
    }
}
