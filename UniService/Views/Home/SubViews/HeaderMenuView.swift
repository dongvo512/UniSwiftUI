//
//  HeaderMenuView.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import SwiftUI

struct HeaderMenuView: View {
    
    var menuType:MenuType = .today
    
    var body: some View {
        
        HStack{
            Text(menuType.title)
                .font(.heading5Medium())
                .foregroundColor(.text100)
            
            Spacer()
            
            Text("view_menu".localized())
                .font(.paragraph2Medium())
                .foregroundColor(.primary100)
            Image("ic_arrow_right").renderingMode(.template)
                .foregroundColor(.primary100)
                .frame(width: 24, height: 24)
            
        }
    }
}

#Preview {
    HeaderMenuView()
}
