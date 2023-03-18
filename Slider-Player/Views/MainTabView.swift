//
//  MainTabView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.03.2023.
//
/*
    Main Page of App with TabBar
 */

import SwiftUI

struct MainTabView: View {
    @State var tabSelected = 0
    
    var body: some View {
        TabView(selection: $tabSelected) {
            
            PlayerView()
                .badge(Piece().pieceTrack.count)
                .tabItem {
                    Label("Player", systemImage: "play.rectangle.on.rectangle.fill")}
                .tag(1)
            
            FeedView()
                .badge(FeedViewModel().posts.count)
                .tabItem {
                    Label("Feed", systemImage: "doc.richtext")
                }
                .tag(2)
                                    
            AlbumView()
                .badge("?")
                .tabItem {
                    Label("Album", systemImage: "photo.stack.fill")
                }
                .tag(3)
            
            SettingsView()
//                .badge("")
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }
                .tag(4)
            
            ExamplesView()
                .badge(2)
                .tabItem {
                    Label("Useful", systemImage: "gear")
                }
                .tag(5)
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            
    }
}
