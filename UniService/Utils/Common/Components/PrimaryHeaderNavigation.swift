//
//  PrimaryHeaderNavigation.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import SwiftUI

struct PrimaryHeaderNavigation: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isBack:Bool
    
    var title:String
    var tralingButton: AnyView? = nil
    
    var body: some View {
        HStack{
            
            if isBack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image("btn_back")
                        .frame(width: 44, height: 44)
                })
            }
            else{
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white100)
            }
            
            Spacer()
            
            Text(title)
                .titlePage()
            
            Spacer()
            
            if let tralingButton = tralingButton {
                tralingButton
            }
            else{
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white100)
            }
        }
    }
}

#Preview {
    PrimaryHeaderNavigation(isBack: .constant(false), title: "Title")
}
