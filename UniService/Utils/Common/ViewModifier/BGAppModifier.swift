//
//  BGAppModifier.swift
//  UniService
//
//  Created by Admin on 11/01/2024.
//

import SwiftUI

struct BGAppModifier: ViewModifier {
  
    func body(content: Content) -> some View {
            content
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.bgPrimary)
    }
}

extension View {
    func bgAppModifier() -> some View {
        ModifiedContent(content: self, modifier: BGAppModifier())
    }
}
