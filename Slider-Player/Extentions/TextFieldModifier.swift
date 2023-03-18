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

extension View {
    func buttonModifier() -> some View {
        modifier(MyButtonModifier())
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
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(ProfileForm().frameColor, lineWidth: 1.2))
//            .padding(.horizontal, 12)
    }
}

struct MyButtonModifier: ViewModifier  {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 40)
            .font(.some(.title))
            .foregroundColor(.white)
            .background(Color.blue)
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.cyan]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
