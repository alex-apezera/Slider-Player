//
//  toolbarView.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    var toolBarView: some View {
        HStack(spacing: 0) {
            searchBar
                .offset(x: 10)
            Spacer()
            if isSearching {
                Button { // Dismiss system keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation {
                        isSearching = false
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 50, height: 30)
                        .shadow(radius: 6, y: 4)
                }
//                .tint(.white)
            } else {
                settingsButton
            }
            Spacer()
        }
        .padding(.bottom)
    }
}
