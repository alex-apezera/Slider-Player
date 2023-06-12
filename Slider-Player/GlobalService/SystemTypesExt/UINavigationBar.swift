//
//  UINavigationBar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import SwiftUI

//MARK: - UINavigationBar

// created from Capturing Photos on 21.03.2024
 extension UINavigationBar {
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
