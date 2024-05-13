//
//  ProductEmptyView.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import SwiftUI

struct PrimaryEmptyView: View {
    
    var imgStr:String = "img_empty_menu"
    var content:String = "no_items_available".localized()
    
    var body: some View {
        
        HStack{
            Spacer()
            VStack(spacing: 12, content: {
                Image(imgStr)
                Text(content)
                    .font(.paragraph2Regular())
                    .foregroundColor(.text80)
            })
            .frame(alignment:.center)
            .listRowSeparator(.hidden)
              Spacer()
          }
        .padding(.vertical, 12)
    }
}

#Preview {
    PrimaryEmptyView()
}
