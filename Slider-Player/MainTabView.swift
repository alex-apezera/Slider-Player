//
//  MainTabView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.03.2023.
//

import SwiftUI

struct MainTabView: View {
    @State var tabSelected = 0
    
    var body: some View {
        TabView(selection: $tabSelected) {
            
            PlayerView()
                .badge(3)
                .tabItem {
                    Label("Player", systemImage: "play.rectangle.on.rectangle.fill")}
                .tag(0)
            
            ReceivedView()
                .badge(2)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(1)
            
            FeedView()
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
                .tag(2)
            
            AccountView()
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(3)
        }
        .font(.headline)
        .accentColor(.cyan)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
