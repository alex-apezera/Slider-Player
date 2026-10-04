//
//  KeyboardStyle.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.12.2023.
//

import SwiftUI

public protocol KeyboardStyle {
    associatedtype Layout: View

    var naturalKeySpace: CGFloat { get }
    func naturalColor(_ down: Bool) -> Color
    func sharpFlatColor(_ down: Bool) -> Color
    func labelColor(_ noteNumber: Int) -> Color
    func layout(viewModel: PianoKeyboardViewModel, geometry: GeometryProxy) -> Layout
}
