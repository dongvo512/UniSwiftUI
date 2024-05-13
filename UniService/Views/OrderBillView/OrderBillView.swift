//
//  OrderBillView.swift
//  UniService
//
//  Created by Admin on 18/03/2024.
//

import SwiftUI

struct OrderBillView: View {
    
    var idBill:String
    @Binding var isShouldPopToRootView:Bool
    
    @StateObject private var orderBillViewModel = OrderBillViewModel()
    
    var body: some View {
        
        VStack {
            PrimaryHeaderNavigation(isBack: .constant(true), title: "invoice".localized())
            
            Spacer()
            
            TotalView(titleBtnTotal: "back_to_home_page".localized(), isOutLine:true) {
                isShouldPopToRootView = false
            }
        }
        .onAppear(){
            Task{
                await orderBillViewModel.getOrderBillDetail(idBill: idBill, isRefreshing: false)
            }
            
        }
        .navigationBarHidden(true)
        .bgAppModifier()
    }
}

#Preview {
    OrderBillView(idBill: "123456", isShouldPopToRootView: .constant(false))
}
