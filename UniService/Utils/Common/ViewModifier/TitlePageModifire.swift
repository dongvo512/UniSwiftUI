//
//  BGAppModifier.swift
//  UniService
//
//  Created by Admin on 11/01/2024.
//

import SwiftUI

struct TitlePageModifire: ViewModifier {
  
    func body(content: Content) -> some View {
            content
            .frame(maxWidth: .infinity, minHeight: 44)
            .lineLimit(2)
            .font(.subTitle2Bold())
            .foregroundColor(.text100)
    }
}

extension View {
    func titlePage() -> some View {
        ModifiedContent(content: self, modifier: TitlePageModifire())
    }
}
