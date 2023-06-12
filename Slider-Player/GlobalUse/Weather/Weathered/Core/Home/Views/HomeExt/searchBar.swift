//
//  searchBar.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    
    var searchBar: some View {
        ZStack {
            Capsule()
                .foregroundStyle(.thinMaterial)
                .frame(width: 310, height: 40)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 5)
                TextField("Search for a location", text: $searchText)
                    .autocorrectionDisabled()
                    .onTapGesture {
                        isSearching = true
                    }
                Spacer()
                if isSearching && !searchText.isEmpty {
                    Button {
                        searchText = ""
                        weatherVM.weatherData = nil
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing, 5)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(width: 320, height: 40)
        }
    }
}
