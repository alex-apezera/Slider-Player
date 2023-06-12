//
//  GesturesMenu.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2023.
//

import SwiftUI

struct GesturesMenu: View {
    
    enum NavigationOption {
        case tap, longPress, drag, rotate, line, doubleTap
    }
    
    @State private var selection: NavigationOption?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                GestureRow(title: "Tap", description: "Tap a shape to interact.", systemImage: "hand.point.up.left")
                    .tag(NavigationOption.tap)
                GestureRow(title: "Touch and Hold", description: "Touch and hold a shape to interact.", systemImage: "hand.tap")
                    .tag(NavigationOption.longPress)
                GestureRow(title: "Drag", description: "Drag a shape using one finger.", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                    .tag(NavigationOption.drag)
                GestureRow(title: "Rotate", description: "Rotate a shape with two fingers.", systemImage: "arrow.triangle.2.circlepath")
                    .tag(NavigationOption.rotate)
                GestureRow(title: "Line Drawing", description: "Use your finger to draw a simple line shape.", systemImage: "pencil.tip")
                    .tag(NavigationOption.line)
                GestureRow(title: "Double Tap", description: "Double tap to open/close gradient view.", systemImage: "rectangle.and.hand.point.up.left")
                    .tag(NavigationOption.doubleTap)
            }
            .navigationTitle("Gestures")
            
        } detail: {
            
            if let selection {
                switch selection {
                case .tap: TapView()
                case .longPress: LongPressView()
                case .drag: DragView()
                case .rotate: RotateView()
                case .line: SingleLine()
                case .doubleTap: ComposedGestureView()
                }
            } else {
                Text("Select a Gesture Example")
                    .foregroundColor(.secondary)
            }
        }
        .navigationModifier("Gesture experience")
    }
}

#Preview {GesturesMenu()}
