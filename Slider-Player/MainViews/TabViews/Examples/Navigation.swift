//
//  Navigation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.11.2023.
//

import SwiftUI

struct Navigation: View {
    let colors: [Color] = [.purple, .pink, .orange]
    @State private var selection: Color? = nil // Nothing selected by default.


    var body: some View {
        NavigationSplitView {
            List(colors, id: \.self, selection: $selection) { color in
                NavigationLink(color.description, value: color)
            }
        } detail: {
            if selection != nil {
                Color.random()
            } else {
                Text("Pick a color")
            }
        }
        .navigationBarTitle("Navigation Split View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Navigation()
}
