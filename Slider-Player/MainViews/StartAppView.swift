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
    @State private var startSub1Menu = false
    @State private var startNewMap = false
    @AppStorage("password") var password = ""

    init() {
        UINavigationBar.applyCustomAppearance()/// Deleting system inscription on bar line
        password = ""/// Required when starting the App again
    }

    var body: some View {
        VStack {
            if !startMainMenu, !startNewMap, !startSub1Menu {
                LaunchView(start: $startMainMenu, startNewMap: $startNewMap)
            }  else if startMainMenu {
                MainTabView(backToLaunchView: $startMainMenu)
            } else if startNewMap, #available(iOS 17.0, *) {
                NewMapView(startNewMap: $startNewMap)
            }
        }
    }
}
