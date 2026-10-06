//
//  ViewModifiers.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 05.03.2023.
//

import SwiftUI

//MARK: - Navigation modifier

struct NavigationModifier: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .buttonStyle(.borderless)
            .listStyle(.inset)
            .background(.thinMaterial)
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
//MARK: - Gradient

struct GradientEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .padding(5)
            .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.cyan]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10.0)
            .shadow(radius: 5)
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

/// Возврат на предыдущий уровень
struct NavigationDone: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode
    func body(content: Content) -> some View {
        content
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "checkmark")
            })
    }
}

