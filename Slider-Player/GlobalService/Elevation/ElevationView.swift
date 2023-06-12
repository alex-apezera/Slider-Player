//
//  ElevationView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.10.2024.
//
// Get Api from open-elevation.com

import SwiftUI
import CoreLocation

struct ElevationView: View {
    let coordinate: CLLocationCoordinate2D
    @State var results = [ApiData]()
    
    var body: some View {
        Text("\(.altitude): \((results.first?.elevation ?? 0).formatted(.number.precision(.fractionLength(0))))")
            .task {
                await fetchElevation()
            }
    }
}

extension ElevationView {
    func fetchElevation() async {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let searchRequest = "\(latitude),\(longitude)"
        guard let url = URL(string: "https://api.open-elevation.com/api/v1/lookup?locations=\(searchRequest)") else {
            print(#function, "Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ElevationData.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print(#function, "Invalid data")
        }
    }
}
