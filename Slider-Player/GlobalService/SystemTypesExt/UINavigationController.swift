//
//  UINavigationController.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.11.2024.
//
import SwiftUI

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
