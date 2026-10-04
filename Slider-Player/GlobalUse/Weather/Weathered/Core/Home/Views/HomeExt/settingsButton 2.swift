//
//  settingsButton.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    
    var settingsButton: some View {
        Menu {
            Section(header: Text("Map Style")) {
                
                Button { locationVM.mapStyle = .standard(elevation: .realistic, pointsOfInterest: .excludingAll)
                } label: { Text("Explore") }
                
                Button { locationVM.mapStyle = .imagery(elevation: .realistic)
                } label: { Text("Satellite") }
            }
            Section(header: Text("Font Design")) {
                
                Button { fontDesign = .default
                } label: { Text("Default") }
                
                Button { fontDesign = .monospaced
                } label: { Text("Monospaced") }
                
                Button { fontDesign = .serif
                } label: { Text("Serif") }
                
                Button { fontDesign = .rounded
                } label: { Text("Rounded") }
            }
        } label: {
            Image(systemName: "gear")
                .resizable()
                .foregroundColor(.white)
                .scaledToFit()
                .frame(width: 50, height: 30)
                .shadow(radius: 6, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
