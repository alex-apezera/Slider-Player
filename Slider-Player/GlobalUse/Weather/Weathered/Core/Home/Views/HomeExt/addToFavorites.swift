//
//  addToFavorites.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    
    var addToFavoritesView: some View {
        Button {
            if let weatherData = weatherVM.weatherData {
                let newFavorite = FavoritePlace(
                    name: weatherData.location.name,
                    region: weatherData.location.region,
                    country: weatherData.location.country,
                    latitude: weatherData.location.lat,
                    longitude: weatherData.location.lon)
                
                modelContext.insert(newFavorite)
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            
            Label("Favorite", systemImage: locationIsFavorite ? "heart.fill" : "heart")
                .symbolRenderingMode(.multicolor)
                .padding(.top, 2)
        }
        .tint(.white)
        .disabled(locationIsFavorite)
    }
}
