//
//  PrimaryButton.swift
//  UniService
//
//  Created by Admin on 19/01/2024.
//

import SwiftUI

struct PrimaryButton: View {
   
    var title:String
    var heightButton:CGFloat?
    var isEnable:Bool = true
    var state:BaseState? = nil
    var imageStr:String? = nil
    var tintColorIcon:Color? = nil
    var onPressed : () -> ()
    
    var body: some View {
        
        Button(action: onPressed) {
            if case .onLoading = state {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white100))
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            else{
                HStack {
                    
                    Spacer()
                    
                    if let imgStr = imageStr {
                        Image(imgStr)
                            .renderingMode(.template)
                            .foregroundColor(tintColorIcon ?? Color.white)
                    }
                    
                    Text(title)
                        .font(.paragraph2Medium())
                        .padding(.vertical, 12)
                        .foregroundColor((isEnable) ? .white100 : .text60)
                       // .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Spacer()
                }
                
            }
        }
        .frame(height: heightButton ?? 44.0)
        .disabled(!isEnable)
        .background(RoundedRectangle(cornerRadius: 8).fill((isEnable) ? .primary100 : .gray24))
    }
}

#Preview {
    PrimaryButton(title: "Login".localized(), isEnable: false, state: BaseState.onIdle, onPressed: {})
}
