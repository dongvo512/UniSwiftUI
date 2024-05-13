//
//  PrimaryButton.swift
//  UniService
//
//  Created by Admin on 19/01/2024.
//

import SwiftUI

struct SecondButton: View {
   
    var title:String
    var onPressed : () -> ()
    var heightButton:CGFloat?
    var isEnable:Bool = true
    var state:BaseState? = nil
    
    var body: some View {
        
        Button(action: onPressed) {
            if case .onLoading = state {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white100))
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            else{
                Text(title)
                    .font(.paragraph2Medium())
                    .padding(.vertical, 12)
                    .padding(.horizontal, 40)
                    .foregroundColor((isEnable) ? .white100 : .text60)
            }
        }
        .frame(height: heightButton ?? 44.0)
        .disabled(!isEnable)
        .background(RoundedRectangle(cornerRadius: 8).fill((isEnable) ? .primary100 : .gray24))
    }
}

#Preview {
    SecondButton(title: "Login".localized(), onPressed: {}, isEnable: false, state: BaseState.onIdle)
}
