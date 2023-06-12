//
//  UserPoint.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.04.2024.
//
//MARK: - Current Point Location

import SwiftUI
import CoreLocation

class CurrentPoint: ObservableObject {
    @ObservedObject var locationManager = LocationManager()
    
    var currentLatitude: CLLocationDegrees {return locationManager.location?.latitude ?? 0}
    var currentLongitude: CLLocationDegrees {return locationManager.location?.longitude ?? 0}
    
    var currentCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
    }

    var currentLocation: CLLocation {
        return CLLocation(latitude: currentLatitude, longitude: currentLongitude)
    }
}
