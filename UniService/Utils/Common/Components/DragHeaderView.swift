//
//  DragHeaderView.swift
//  UniService
//
//  Created by Admin on 30/01/2024.
//

import SwiftUI

struct DragHeaderView: View {

    var body: some View {
        Rectangle()
            .fill(.gray24)
            .frame(width: 33, height: 4)
            .cornerRadius(2)
    }
}

#Preview {
    DragHeaderView()
}
