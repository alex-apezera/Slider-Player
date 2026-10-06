//
//  ViewModifiers.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import SwiftUI

extension View {
    
    var textModifier: some View {
        modifier(TextModifier())
    }
    func navigationModifier(_ title: String) -> some View {
        modifier(NavigationModifier(title: title))
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func blinking(duration: Double = 0.2) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
    var textFieldModifier: some View {
        modifier(TextFieldModifier())
    }
    var customTextModifier: some View {
        modifier(CustomObjectTextModifier())
    }
    func feedModifier() -> some View {
        modifier(FeedCellModifier())
    }
    var gradientModifier: some View {
        modifier(GradientEffect())
    }
    /// Return on the back level
    var done: some View {
        modifier(NavigationDone())
    }

}
