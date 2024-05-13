//
//  TotalView.swift
//  UniService
//
//  Created by Admin on 18/03/2024.
//

import SwiftUI

struct TotalView: View {
    
    var totalPrice:Int = 0
    var titleBtnTotal:String = "pay".localized()
    var isOutLine:Bool = false
    var onPressed : () -> ()
    
    var body: some View {
        
        VStack (spacing:12.0){
            Spacer()
            
            Divider()
            
            HStack {
                Text("total".localized())
                    .font(.paragraph2Regular())
                Spacer()
                
                Text("\(totalPrice.formatnumber()) đ")
                    .font(.heading6Bold())
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 8.0)
            
            if isOutLine {
                
                SecondButtonOutline(title: titleBtnTotal) {
                    onPressed()
                }
                .padding(.horizontal, 16.0)
                .padding(.bottom, 12.0)
            }
            else{
                PrimaryButton(title: titleBtnTotal) {
                    onPressed()
                }
                .padding(.horizontal, 16.0)
                .padding(.bottom, 12.0)
            }
        }
    }
}

#Preview {
    TotalView(totalPrice: 35000, onPressed: {})
}
