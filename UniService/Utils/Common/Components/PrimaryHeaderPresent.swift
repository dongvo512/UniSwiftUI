//
//  PrimaryHeaderPresent.swift
//  UniService
//
//  Created by Admin on 13/5/24.
//

import SwiftUI

struct PrimaryHeaderPresent: View {
    var onClossed : (() -> Void)? = nil
    var title:String = S.empty
    
    var tralingButton: AnyView? = nil
    
    var body: some View {
        HStack{
            
            Button(action: {
                onClossed?()
            }, label: {
                Image("btn_close_white")
                    .frame(width: 44, height: 44)
            })
            
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
    PrimaryHeaderPresent(title: "purchase".localized())
}
