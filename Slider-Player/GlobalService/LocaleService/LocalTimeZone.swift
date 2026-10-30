//
//  LocalTimeZone.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.10.2024.
//

/*
// Deprecate
import SwiftUI
import CoreLocation

struct LocalTimeZone {
    
    @Binding var timeZone: TimeZone?
    
    func getTimeZone(coordinate: CLLocation) {
        @State var timeZone: TimeZone?
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(coordinate) {placemarks, error in
            if let error {
                print(error.localizedDescription)
            } else {
                if let placemarks {
                    if let localTimeZone = placemarks.first!.timeZone {
                        self.timeZone = localTimeZone
                        print(self.timeZone as Any)
                    }
                }
            }
        }
    }
}
*/

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
                    print(tz)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
