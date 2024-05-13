//
//  FromToDateView.swift
//  UniService
//
//  Created by Admin on 26/02/2024.
//

import SwiftUI

enum FromToDateType {
    case from
    case to
    
    var title: String {
        switch self {
        case .from:
            "from".localized()
        case .to:
            "to".localized()
        }
    }
}

struct FromToDateView: View {
    @EnvironmentObject var tabTransactionViewModel:TabTransactionsViewModel
//    @Binding var fromDate:Date
//    @Binding var toDate:Date
//    var onChangedFromDate : ((Date) -> Void)
//    var onChangedToDate : ((Date) -> Void)
    
    var body: some View {
        
        HStack(spacing:16){
            
            _itemDateView(fromToType: .from)
                .overlay{
                    DatePicker(
                        "",
                        selection: $tabTransactionViewModel.fromDate,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .blendMode(.destinationOver) //MARK: use this extension to keep the clickable functionality
                    .onChange(of: tabTransactionViewModel.fromDate, perform: { value in
                        tabTransactionViewModel.fromDate = value
                        tabTransactionViewModel.fetchAll()
                       // onChangedFromDate(value)
                    })
                }
            _itemDateView(fromToType: .to)
                .overlay{
                    DatePicker(
                        "",
                        selection: $tabTransactionViewModel.toDate,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .blendMode(.destinationOver) //MARK: use this extension to keep the clickable functionality
                    .onChange(of: tabTransactionViewModel.toDate, perform: { value in
                        tabTransactionViewModel.toDate = value
                        tabTransactionViewModel.fetchAll()
                        
                       // onChangedToDate(value)
                    })
                }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder private func _itemDateView(fromToType:FromToDateType) -> some View{
        HStack{
            Text(fromToType.title)
                .font(.captionMedium())
                .foregroundColor(.text100)
            
            HStack(spacing:22){
                
                Text((fromToType == .from) ? tabTransactionViewModel.fromDate.formatDateToString() : tabTransactionViewModel.toDate.formatDateToString())
                    .font(.captionMedium())
                    .foregroundColor(.text100)
                
                Spacer()
                
                Image("ic_down").renderingMode(.template)
                    .foregroundColor(.text100)
                
            }
            .padding(.vertical,8)
            .padding(.horizontal, 12)
            .border(.gray24, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, cornerRadius:24)
            .background(RoundedRectangle(cornerRadius: 24,style: .continuous).fill(
                .white100))
            
            
        }
        
    }
}

#Preview {
    FromToDateView()
}
