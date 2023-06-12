//
//  AnyButton.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.06.2025.
//

import SwiftUI

struct AnyButton: View {
    let icon: String
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: icon)
        }
    }
}
