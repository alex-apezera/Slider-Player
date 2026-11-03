//
//  StartAppView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.02.2024.
//
//MARK: - activate Launch screen with select menu

import SwiftUI

struct StartAppView: View {
    @State private var startMainMenu = false
    @AppStorage("password") var password = ""

    init() {
        
        // Deleting system inscription on bar line
        UINavigationBar.applyCustomAppearance()
        
        // Required when starting the App again
        password = ""
    }

    var body: some View {
        VStack {
            if !startMainMenu {
                LaunchView(start: $startMainMenu)
            }  else {
                MainTabView(backToLaunchView: $startMainMenu)
            }
        }
    }
}
