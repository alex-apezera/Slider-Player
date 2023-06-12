//
//  ButtonStyle.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 16.05.2025.
//

import SwiftUI

///Style wthich apply gradient ang hover effect (or double tap like hovering) with comment)

struct Hovering: ButtonStyle {
    let hoverMessage: String
    @State var isHovering: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onHover { onHover in withAnimation {isHovering = onHover} }
            .scaleEffect(isHovering ? 0.9 : 1.0)
            .onTapGesture(count: 2) {withAnimation {isHovering.toggle()}}
            .gradientModifier
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
        if isHovering {
            Text(hoverMessage).padding(5)
                .background(.gray, in: .rect(cornerRadius: 5).stroke(style: .init(lineWidth: 1)))
                .background(.thickMaterial)
            //It works if available mouse or trackpad devices
        }
        
    }
}

///Style wthich apply  increase effect
///
struct Increasing: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.accentColor)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .shadow(radius: configuration.isPressed ? 7 : 5)
    }
}

//MARK: - Hover effect
/*
@available(iOS 18.0, *)
struct ScaleEffect: CustomHoverEffect {
    func body(content: Content) -> some CustomHoverEffect {
        content.hoverEffect { effect, isActive, geometry in
            effect.animation(.default) {
                $0.scaleEffect(isActive ? 1.1 : 1.0)
            }
        }
    }
}
*/

/*
struct HoverEffect: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.thinMaterial)
            .hoverEffect(.highlight)
            .hoverEffect { effect, isActive, proxy in
                effect.clipShape(.capsule.size(
                    width: isActive ? proxy.size.width : proxy.size.height,
                    height: proxy.size.height,
                    anchor: .leading
                ))
                .scaleEffect(isActive ? 1.1 : 1)
            }
        
    }
}
*/

