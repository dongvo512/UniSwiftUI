//
//  BranchsPageView.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import SwiftUI

struct BranchsPageView: View {
  
    var isBack:Bool = false
    @State private var isChangedBranch:Bool = false
    @ObservedObject var branchsViewModel = BranchsViewModel()
    @State private var _selectedBranch:Branch? = LocaleStorageService.shared.getBranchCurr()
    
    var body: some View {
        
        if isChangedBranch {
            MainPageView()
            
        }
        else{
            VStack{
                if isBack {
                    PrimaryHeaderNavigation(isBack: .constant(isBack), title: "select_branch".localized())
                }
                else{
                    Text("select_branch".localized())
                        .titlePage()
                }
                
                List{
                    ForEach(branchsViewModel.branchs) { branch in
                        BranchItemView(branch: branch, idSelectedBranch: _selectedBranch?.id)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .listRowSeparator(.hidden)
                            .background(.bgPrimary)
                            .onTapGesture {
                                _selectedBranch = branch
                            }
                    }
                }
                .listStyle(.plain)
                
                Spacer()
                
                PrimaryButton(title: "next".localized(), isEnable: (_selectedBranch != nil) ? true : false, onPressed: {
                    
                    if let selectedbranch = _selectedBranch {
                        LocaleStorageService.shared.saveBranchCurr(branch: selectedbranch)
                        isChangedBranch = true
                    }
                    
                })
                .padding(.horizontal, 16)
                
            }
            .navigationBarHidden(true)
            .bgAppModifier()
        }
    }
}

#Preview {
    BranchsPageView()
}
