//
//  TextFieldModifier.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 05.03.2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func myTextModifier() -> some View {
        modifier(TextFieldModifier())
    }
}

extension View {
    func feedModifier() -> some View {
        modifier(FeedCellModifier())
    }
}

struct FeedCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 20, height: 20)
            .font(.system(size: 20))
            .padding(4)
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.accentColor)
            .font(.system(size: 24))
            .keyboardType(.emailAddress)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.red))
            .padding(.horizontal, 12)
    }
}
