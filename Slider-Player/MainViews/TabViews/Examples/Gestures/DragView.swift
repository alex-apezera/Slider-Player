//
//  DragView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct DragView: View {
    
    private let circleSize: CGFloat = 100
    @State private var offset = CGSize.zero
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = CGSize(width: value.startLocation.x + value.translation.width - circleSize/2,
                                height: value.startLocation.y + value.translation.height - circleSize/2)
            }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Circle()
                .foregroundColor(.teal)
                .frame(width: circleSize, height: circleSize)
                .offset(offset)
                .gesture(dragGesture)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            Text("Use one finger to drag the circle around")
                .padding()
        }
        .navigationModifier("Drag")
        .toolbar {
            Button("Reset") {
                offset = .zero
            }
        }
    }
}

#Preview {DragView()}
