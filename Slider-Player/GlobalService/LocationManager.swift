//
//  MyLocation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.06.2023.
//
//  First borrowed from Jakub Jelinek on 11/03/2023. (GitHub -jakjel/Maps-SwiftUI)

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var location: CLLocationCoordinate2D?
    
    var manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    var statusString: String {
        guard let status = locationStatus else {
            return "default"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "default"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else {
            print(#function, "didnt get location!")
            return
        }
        DispatchQueue.main.async {
            self.location = location
        }
        
        guard let location = locations.first else {
            return
        }
        lastLocation = location
        manager.stopUpdatingLocation()
    }
    
    // Checks if LS is enabled, configures location manager
    func checkIfLocationServicesIsEnabled() {
            manager = CLLocationManager()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: break //access granted
        case .denied, .restricted:
            print("Location access denied.")
        case .notDetermined:
            print("Location status not determined.")
            manager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("New case for CLLocationManagerDelegate?")
        }
    }
    
    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
