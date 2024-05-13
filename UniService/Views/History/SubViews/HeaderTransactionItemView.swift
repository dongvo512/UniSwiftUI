//
//  TabTransactionItemView.swift
//  UniService
//
//  Created by Admin on 26/02/2024.
//

import SwiftUI

struct HeaderTransactionItemView: View {
    
    var transactionItem:TabTransactionItem
    var selectedTransactionIndex:Int
    let min_width:CGFloat = 83.0
    
    var body: some View {
        
        ZStack {
            VStack {
                Text(transactionItem.type.title)
                    .font(.subTitle3Bold())
                    .foregroundColor((transactionItem.type.index == selectedTransactionIndex) ? .primary100 : .text100)
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
        .frame(minWidth: min_width, maxHeight: 32)
        .border(.gray24, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, cornerRadius:24)
        .background(RoundedRectangle(cornerRadius: 24,style: .continuous).fill(
            (transactionItem.type.index == selectedTransactionIndex) ? .blue8 :.white100))
    }
}

#Preview {
    Group {
        HeaderTransactionItemView(transactionItem: TabTransactionItem(type: .all), selectedTransactionIndex: 0)
    }
}
