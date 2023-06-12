//
//  PlaybackControlButton.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.04.2023.
//
// Used in ShowPlayer

import SwiftUI

struct PlaybackControlButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 28
    var color: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: systemName).font(.system(size: fontSize)).foregroundColor(color)
        }

    }
}
