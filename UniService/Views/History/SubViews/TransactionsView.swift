//
//  TransactionsView.swift
//  UniService
//
//  Created by Admin on 27/02/2024.
//

import SwiftUI

struct TransactionsView: View {
   
    @EnvironmentObject var tabTransactionViewModel:TabTransactionsViewModel
    var tabType:TabTransactionType

    var body: some View {
        List{
            ForEach(tabTransactionViewModel.getTransactionsItemWithTabType(tabType: self.tabType) ?? []){
                transactionItem in
                TransactionItemView(transaction: transactionItem)
                    .id(transactionItem.id)
                    .onAppear(){
                        tabTransactionViewModel.shouldLoadMore(tabType: self.tabType, transaction: transactionItem)
                    }
            }
        }
        .refreshable{
            await tabTransactionViewModel.fetchDataWithTabType(tabType: self.tabType)
        }
        .listStyle(.plain)
    }
}

#Preview {
    TransactionsView(tabType:.all)
}
