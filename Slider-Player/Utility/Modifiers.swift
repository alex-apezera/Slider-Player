//
//  ViewModifiers.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 05.03.2023.
//

import SwiftUI

//MARK: - Useful Snipset Modifiers

//            .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 100, green: 100, blue: 100).opacity(0.7), Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom))

//            .clipShape(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))

//MARK: - Text for Weathered

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.leading, 20)
            .padding(.top, 10)
            .padding(.bottom, 5)
            .opacity(0.6)
    }
}
extension View {
    var textModifier: some View {
        modifier(TextModifier())
    }
}

//MARK: - FeedCell

struct FeedCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 20, height: 20)
            .font(.system(size: 20))
            .padding(4)
    }
}
//MARK: - TextField

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.accentColor)
            .font(.system(size: 24))
            .keyboardType(.emailAddress)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.orange, lineWidth: 1.2))
    }
}
//MARK: - CustomObjectText

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
//MARK: - MyButton

struct MyButtonModifier: ViewModifier  {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 40)
            .font(.some(.title))
            .foregroundColor(.white)
            .background(Color.blue)
            .shadow(radius: 5)
    }
}
//MARK: - GradientButtonStyle

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.cyan]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .shadow(radius: 5)
    }
}
//MARK: - IncreaseButton

struct IncreaseButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.accentColor)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .shadow(radius: configuration.isPressed ? 7 : 5)
    }
}

//MARK: - Blinking Modifier

struct BlinkViewModifier: ViewModifier {
    let duration: Double
    @State var blink: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(blink ? 0 : 1)
            .animation(.easeOut(duration: duration).repeatForever(), value: blink)
            .onAppear { withAnimation { blink = true } }
    }
}
