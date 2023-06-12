//
//  TextModifiers.swift
//  Weathered
//
//  Created by Алексей Езерский on 08.09.2024.
//

import SwiftUI

/// see  View+Modifiers

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.leading, 20)
            .padding(.top, 10)
            .padding(.bottom, 5)
            .opacity(0.6)
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.accentColor)
            .font(.callout)
            .keyboardType(.emailAddress)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.orange, lineWidth: 1.2))
    }
}

struct CustomObjectTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
            .background(.ultraThinMaterial)
            .shadow(radius: 5)
            .cornerRadius(15)
            .font(.body)
            .lineLimit(.max)
            .multilineTextAlignment(.leading)
            .keyboardType(.emailAddress)
    }
}

