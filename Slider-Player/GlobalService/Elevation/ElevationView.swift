//
//  ElevationView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.10.2024.
//

import SwiftUI
import CoreLocation

/// Response Altitude
struct ElevationView: View {
    
    let coordinate: CLLocationCoordinate2D
    @State var results = [ApiData]()
    
    /// dataset may be: srtm30m, aster30m, eudem25m, mapzen
    @AppStorage("openTopoDataset") var dataset = "srtm90m"
    
    var body: some View {
        Text("\(String.altitude): \((results.first?.elevation ?? 0).formatted(.number.precision(.fractionLength(0)))) m")
            .task {
                await fetchElevation()
            }
    }
}

extension ElevationView {
    
    /// Request to OpenTopoData
    func fetchElevation() async {
        let locations = String(format: "%.6f,%.6f",
                               coordinate.latitude,
                               coordinate.longitude)

        guard let url = URL(string:
            "https://api.opentopodata.org/v1/\(dataset)?locations=\(locations)")
                else { print("🌐 Invalid URL"); return }
        print("🌐 URL=", url)

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let http = response as? HTTPURLResponse else {
                print("🌐 No HTTP response"); return
            }
            guard http.statusCode == 200 else {
                print("🌐 BAD STATUS:", http.statusCode); return
            }

            do {
                let decoded = try JSONDecoder().decode(ElevationData.self, from: data)
                results = decoded.results
                print("🌐 получено:", results.count,
                      "высота:", results.first?.elevation ?? 0,
                      "status:", decoded.status ?? "?")
            } catch { print("🌐 DECODE ERROR:", error) }
        } catch { print("🌐 NETWORK ERROR:", error) }
    }

    /*
    /// Request to Open-elevation
    func fetchElevation() async {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let searchRequest = "\(latitude),\(longitude)"
        guard let url = URL(string: "https://api.open-elevation.com/api/v1/lookup?locations=\(searchRequest)") else {
            print("🌐", "Invalid URL")
            return
        }
        print("🌐 URL=", url, searchRequest)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decoded = try JSONDecoder().decode(ElevationData.self, from: data)
                results = decoded.results
                print("🌐 получено:", results.count, results.first?.elevation ?? -1)
            } catch {
                print("🌐 DECODE ERROR:", error)
            }
        } catch {
            print("🌐 NETWORK ERROR:", error)
        }

    }
     */
}
