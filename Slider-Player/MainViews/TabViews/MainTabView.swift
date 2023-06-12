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
    @AppStorage("newsCount") var newsCount: Int = 0

    @ObservedObject private var manager = MusicFileManager.shared
    
    var body: some View {
        TabView(selection: $tabSelected) {
            
            //MARK: - Player content
            NavigationView {PlayerView()}
                .badge(manager.pieces.count + audiosCount + iTunesCount + Piece().pieceNumber.count)
                .tabItem {
                    Label(String.playerTitle, systemImage: "play.rectangle.on.rectangle.fill")
                }.tag(0)
            //MARK: - Album manage
            NavigationView {AlbumView()}
                .badge(lastIndex)
                .tabItem {
                    Label(String.albumTitle, systemImage: "photo.stack.fill")
                }
                .tag(1)
            //MARK: - News
            NavigationView { NewsView() }
                .tabItem {Label(String.news, systemImage: "newspaper")}
                .badge(newsCount)
                .tag(2)
            
            //MARK: - Quakes
            NavigationView { Quakes() }
            .badge(quakesCount)
            .tabItem {
                Label(String.capQuakes, systemImage: "exclamationmark.triangle.fill")
            }.tag(3)
            //MARK: - Useful content
            NavigationView {ExamplesView(backToLaunchView: $backToLaunchView)}
                .badge(tabSelected)
                .tabItem {
                    Label(String.more, systemImage: "ellipsis")
                }.tag(4)
        }
        //MARK: - Init vars
        .onAppear {audiosCount = 0; iTunesCount = 0; newsCount = 0; quakesCount = 0}
        //MARK: - Navigation line and button style
        .navigationModifier(String.mainMenu)
    }
}
