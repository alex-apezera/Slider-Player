//
//  TapView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct TapView: View {
    @State private var color : Color = Color.primary

    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    color = Color.random()
                }
            }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .foregroundColor(color)
                .frame(width: 250, height: 350)
                .gesture(tapGesture)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .overlay(alignment: .top) {
            Text("Tap the rectangle to change its color")
                .padding()
        }
        .navigationModifier("Tap")
        .toolbar {
            Button("Reset") {
                color = Color.primary
            }
        }
    }
}

#Preview {TapView()}
