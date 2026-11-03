//
//  MainTabView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.03.2023.
//

//MARK: - Main menu of App with TabBar

import SwiftUI

struct MainTabView: View {
    @Binding var backToLaunchView: Bool
    
    @AppStorage("tabSelected") var tabSelected = 0
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("audiosCount") var audiosCount: Int = 0
    @AppStorage("iTunesCount") var iTunesCount: Int = 0
    @AppStorage("galleryFilesCount") var galleryFilesCount: Int = 0
    @AppStorage("quakesCount") var quakesCount = 0
    
    @State private var startNewMap = false

    @ObservedObject private var manager = MusicFileManager.shared
    
    var body: some View {
        TabView(selection: $tabSelected) {
            
            // Player content
            NavigationView {PlayerView()}
                .badge(manager.pieces.count + audiosCount + iTunesCount + Piece().pieceNumber.count)
                .tabItem {
                    Label(String.playerTitle, systemImage: "play.rectangle.on.rectangle.fill")
                }.tag(0)
            
            // Album manage
            NavigationView {AlbumView()}
                .badge(lastIndex)
                .tabItem {
                    Label(String.albumTitle, systemImage: "photo.stack.fill")
                }
                .tag(1)
            
            // New Map
            NewMapView(startNewMap: $startNewMap)
                .tabItem {Label(String.newMap, systemImage: "map")}
                .tag(2)
            
            // Quakes
            NavigationView { Quakes() }
            .badge(quakesCount)
            .tabItem {
                Label(String.capQuakes, systemImage: "exclamationmark.triangle.fill")
            }.tag(3)
            
            // Useful examples content
            NavigationView {ExamplesView(backToLaunchView: $backToLaunchView)}
                .tabItem {
                    Label(String.more, systemImage: "ellipsis")
                }.tag(4)
        }
        .onAppear {audiosCount = 0; iTunesCount = 0; quakesCount = 0}
        .titleInline(String.mainMenu)
    }
}
