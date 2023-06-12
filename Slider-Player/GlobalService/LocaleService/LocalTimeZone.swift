//
//  LocalTimeZone.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.10.2024.
//

import SwiftUI
import CoreLocation

struct LocalTimeZone {
    
    @Binding var timeZone: TimeZone?
    
    func getTimeZone(coordinate: CLLocation) {
        @State var timeZone: TimeZone?
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(coordinate) {placemarks, error in
            if let error = error {
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
