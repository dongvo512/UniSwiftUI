//
//  HistoryPageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI

struct HistoryPageView: View {
    
    let height_list_transaction:CGFloat = 58.0
    let transactions:Array<TabTransactionItem> = [
        TabTransactionItem(type: .all),
        TabTransactionItem(type: .purchase),
        TabTransactionItem(type: .deposit),
        TabTransactionItem(type: .tranfer_receive),
        TabTransactionItem(type: .service),
        TabTransactionItem(type: .vending_machine)
    ]
    
    @StateObject private var tabTransactionsViewModel:TabTransactionsViewModel = TabTransactionsViewModel()
    @State private var _selectedTransactionIndex = TabTransactionType.all.index

    @State private var _selectedPage:Int = 0
  
    var body: some View {
        VStack{
            PrimaryHeaderNavigation(isBack: .constant(false), title: "transaction_history".localized())
         
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators:false){
                    LazyHStack(spacing:8){
                        Spacer(minLength: 8)
                        ForEach (Array(transactions.enumerated()), id: \.element){
                            index,itemTransaction in
                            HeaderTransactionItemView(transactionItem:itemTransaction, selectedTransactionIndex: _selectedTransactionIndex).onTapGesture {
                                _selectedTransactionIndex = itemTransaction.type.index
                                
                                withAnimation(.easeOut) {
                                   
                                    _selectedPage = index
                                }
                            }
                            .id(index)
                        }
                        Spacer(minLength: 8)
                    }
                }
                .frame(width: UIScreen.screenWidth, height:height_list_transaction)
                
                FromToDateView().environmentObject(tabTransactionsViewModel)
                
                TabView(selection: $_selectedPage,content: {
                    ForEach (Array(transactions.enumerated()), id: \.element){
                        index ,itemTransaction in
                        TransactionsView(tabType: itemTransaction.type)
                            .environmentObject(tabTransactionsViewModel)
                            .tag(index)
                    }
                })
                .onChange(of: _selectedPage, perform: { newValue in
                    _selectedTransactionIndex = newValue
                    withAnimation {
                        value.scrollTo(newValue, anchor: .center)
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
    
//    private func _refreshAll(){
//        self.allViewModel.fetchData(fromDate: _fromDate, toDate: _toDate)
////        for viewModel in transactionsViewModel {
////            viewModel.fetchData(fromDate: _fromDate, toDate: _toDate)
////        }
//    }
}

#Preview {
    HistoryPageView()
}
