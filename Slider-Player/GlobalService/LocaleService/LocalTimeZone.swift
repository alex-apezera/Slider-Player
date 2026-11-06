//
//  LocalTimeZone.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.10.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocalTimeZone {

    @Binding var timeZone: TimeZone?

    func getTimeZone(coordinate: CLLocation) {
        guard let request = MKReverseGeocodingRequest(location: coordinate) else { return }
        Task {
            do {
                let mapItems = try await request.mapItems
                if let tz = mapItems.first?.timeZone {
                    self.timeZone = tz
                    print("🌐", #function, tz)
                }
            } catch {
                print("🌐", #function, error.localizedDescription)
            }
        }
    }
}
