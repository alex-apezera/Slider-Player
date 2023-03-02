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
            
            ReceivedView()
                .badge(2)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(0)
            
            Text("Sent")
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
                .tag(1)
            
            Text("Account")
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(2)
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
