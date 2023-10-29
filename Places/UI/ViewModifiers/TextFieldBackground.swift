//
//  TextFieldBackground.swift
//  Places
//
//  Created by Dide van Berkel on 26/10/2023.
//

import SwiftUI

struct TextFieldBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

extension View {
    func textFieldBackground() -> some View {
        modifier(TextFieldBackground())
    }
}
