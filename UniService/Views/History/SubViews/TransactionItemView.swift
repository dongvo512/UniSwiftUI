//
//  TransactionItemView.swift
//  UniService
//
//  Created by Admin on 27/02/2024.
//

import SwiftUI

struct TransactionItemView: View {
    
    var transaction:TransactionOjb
    
    var body: some View {
        
        HStack{
            
            Image(transaction.strImg)
                .resizable()
                .scaledToFill()
                .cornerRadius(12)
                .scaledToFill()
                .frame(width: 40, height: 40)
                .background(.white4)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(transaction.name)
                    .foregroundColor(.text100)
                    .font(.paragraph2Medium())
                    .lineLimit(1)
                
                Text(transaction.createdAt?.utcToLocal(formatString: FormatDateType.time.value) ?? S.empty)
                    .foregroundColor(.text80)
                    .font(.paragraph2Regular())
                    .lineLimit(1)
            })
            
            Spacer()
            
            Text(transaction.pointDisplay)
                .foregroundColor(.text100)
                .font(.paragraph1Medium())
                .lineLimit(1)
        }
    }
}

#Preview {
    TransactionItemView(transaction: TransactionOjb())
}
