//
//  Color.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//
import SwiftUI

//MARK: - Random Color

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
