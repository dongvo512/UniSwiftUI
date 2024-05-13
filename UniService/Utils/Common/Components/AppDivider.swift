//
//  AppDivider.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import SwiftUI

struct AppDivider: View {
    
    var height:CGFloat = 1
    
    var body: some View {
        Rectangle()
            .fill(.gray24)
            .frame(height: height)
    }
}

#Preview {
    AppDivider()
}
