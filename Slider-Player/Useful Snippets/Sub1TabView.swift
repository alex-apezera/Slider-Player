//
//  Sub1TabView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 14.02.2025.
//
/*
//MARK: - Main Page of App with TabBar

import SwiftUI

struct Sub1TabView: View {
    @Binding var backToLaunchView: Bool
    @Binding var startMenu: Bool
    
    //MARK: - Properties
    @State private var backToMainView: Bool = false
    @State var movies: [URL] = []
    @AppStorage("sub1TabSelected") var tabSelected = 0
    @AppStorage("quakesCount") var quakesCount = 0
    @AppStorage("newsCount") var newsCount: Int = 0

//    @ObservedObject private var manager = MusicFileManager.shared
    
    @Environment(\.dismiss) var dismiss
    
    //MARK: - Body
    var body: some View {
        TabView(selection: $tabSelected) {
            
            //MARK: - News
            NavigationView { NewsView() }
                .tabItem {Label(String.news, systemImage: "newspaper")}
                .badge(newsCount)
                .tag(0)
            
            //MARK: - Quakes
            NavigationView { Quakes() }
            .badge(quakesCount)
            .tabItem {
                Label(String.capQuakes, systemImage: "exclamationmark.triangle.fill")
            }.tag(1)
            
            //MARK: - Feed
            NavigationView { FeedView() }
            .badge(FeedViewModel().posts.count)
            .tabItem {
                Label(String.menuItemFeed, systemImage: "text.below.photo.fill")
            }.tag(2)

            //MARK: - Useful content
            NavigationView {ExamplesView(backToLaunchView: $backToLaunchView, startMenu: $startMenu)}
                .badge(tabSelected)
                .tabItem {
                    Label(String.more, systemImage: "chevron.left.2")
                }.tag(3)
        }
        //MARK: - Init counts
        .onAppear {newsCount = 0; quakesCount = 0}
        
        //MARK: - Navigation line and button style
        .navigationModifier(String.subMenu)
    }
}
*/
