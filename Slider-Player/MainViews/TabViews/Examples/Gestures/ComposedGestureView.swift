//
//  ComposedGestureView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct ComposedGestureView: View {
    
    @State private var isClosed = true
    
    let singleTapGesture = TapGesture()
    let doubleTapGesture = TapGesture(count: 2)
    let longPressGesture = LongPressGesture(minimumDuration: 2)
    let dragGesture = DragGesture(minimumDistance: 10)
    let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 30))
    
    var sequenceGesture : some Gesture {
        SequenceGesture(singleTapGesture, doubleTapGesture)
            .onEnded { _ in
                withAnimation {
                    isClosed.toggle()
                }
            }
    }
    
    //#-learning-code-snippet(simultaneousGesture)
    
    var body: some View {
        VStack {
            Text("Use your composed gesture to trigger an animation")
            
            Spacer()
            
            
            LinearGradient(colors: [.mint, .teal, .orange], startPoint: .top, endPoint: .bottom)
                .frame(maxHeight: 500)
                .overlay {
                    HStack {
                        Rectangle()
                            .offset(x: isClosed ? 0 : -250, y: 0)
                        Rectangle()
                            .offset(x: isClosed ? 0 : 250, y: 0)
                    }
                }
                .gesture(sequenceGesture)
            
            Spacer()
            
        }
        .navigationModifier("Double tap")
        .padding()
    }
}

#Preview {ComposedGestureView()}
