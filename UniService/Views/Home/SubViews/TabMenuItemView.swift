//
//  MenuItemView.swift
//  UniService
//
//  Created by Admin on 15/01/2024.
//

import SwiftUI

struct TabMenuItemView: View {
    
    var menuItem:TabMenuItem
    var selectedMenuType:TabMenuType
    let min_width:CGFloat = 52.0
    
    var body: some View {
        
        ZStack {
            VStack {
                Image(menuItem.type.iconName).renderingMode(.template)
                    .foregroundColor((menuItem.type == selectedMenuType) ? .primary100 : .text100)
                Text(menuItem.type.title)
                    .font(.subTitle3Bold())
                    .foregroundColor((menuItem.type == selectedMenuType) ? .primary100 : .text100)
                
            }
            .padding(.all,8)
        }
        .frame(minWidth: min_width)
        .border(.gray24, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, cornerRadius:12)
        .background(RoundedRectangle(cornerRadius: 12,style: .continuous).fill(
            (menuItem.type == selectedMenuType) ? .blue8 :.white100))
    }
}

#if DEBUG
#Preview {
    Group {
        TabMenuItemView(menuItem: TabMenuItem(type:.neccessary), selectedMenuType: .neccessary)
    }
}
#endif
