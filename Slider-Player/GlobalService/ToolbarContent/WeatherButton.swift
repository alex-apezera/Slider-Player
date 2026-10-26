//
//  WeatherButton.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.10.2026.
//

import SwiftUI

struct WeatherButton: View {
    let icon: String
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(icon).resizable()
                .scaledToFit()
                .frame(width: 36, height: 30)// оси фиксированы
                .clipShape(Capsule())
                .contentShape(Rectangle())// стабильная hit-area
        }
    }
}
