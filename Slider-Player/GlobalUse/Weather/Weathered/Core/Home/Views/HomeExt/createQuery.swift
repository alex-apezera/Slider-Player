//
//  createQuery.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
import MapKit
@available(iOS 17.0, *)
extension HomeView {
    
    func createQuery() {
        // Start a new timer with a 1-second delay
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            // This block will be executed after user stops typing
            DispatchQueue.main.async {
                searchResultsNeeded = true
                weatherVM.query = searchText
                print(searchText)
                weatherVM.fetchWeatherData()
                
                if let location = weatherVM.weatherData?.location {
                    withAnimation {
                        locationVM.position = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon), distance: 20000, heading: locationVM.heading,  pitch: 60))
                    }
                }
            }
        }
    }
}

