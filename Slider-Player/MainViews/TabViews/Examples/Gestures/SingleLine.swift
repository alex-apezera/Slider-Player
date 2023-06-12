//
//  SingleLine.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct SingleLine: View {
    @State var lineStart = CGPoint.zero
    @State var lineEnd = CGPoint.zero
    var lineDrawingGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                lineStart = value.startLocation
                lineEnd = value.location
            }
            .onEnded { value in
                lineEnd = value.location
            }
    }
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: lineStart)
                path.addLine(to: lineEnd)
            }
            .stroke(Color.accentColor, lineWidth: 8.0)
            .contentShape(Rectangle())
        }
        .gesture(lineDrawingGesture)
        .navigationModifier("Line Drawing")
        .overlay(alignment: .top) {
            Text("Touch and drag to make a line")
                .padding()
        }
        .padding()
        .toolbar {
            Button("Reset") {
                lineStart = .zero
                lineEnd = .zero
            }
        }
    }
}

#Preview { SingleLine() }
