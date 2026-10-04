//
//  RotateView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct RotateView: View {
    @State private var rotation = Angle.zero
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged{ angle in
                rotation = angle
            }
            .onEnded { angle in
                rotation = angle
            }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .foregroundColor(.red)
                .frame(width: 225, height: 225)
                .rotationEffect(rotation)
                .gesture(rotationGesture)
            Spacer()
        }
        .navigationModifier("Rotate")
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            Text("Use two fingers to rotate the box")
                .padding()
        }
        .padding()
        .toolbar {
            Button("Reset") {
                rotation = .zero
            }
        }
    }
}

#Preview {RotateView()}
