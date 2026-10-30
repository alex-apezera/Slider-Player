//
//  GetInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.04.2024.
//
//MARK: - Convert Coordinates of Point to Location Name and Address

import SwiftUI
import MapKit
import CoreLocation

struct GetInfo {
    @Binding var name: String
    @Binding var address: String

    /*
    func convertCoordinateToInfo(_ location: CLLocation) {
        location.placemark { [self] placemark, error in
            guard let placemark = placemark else { return }
            address = placemark.streetName ?? ""
            address += " \(placemark.streetNumber ?? "")"
            address += " \(placemark.city ?? "")"
            address += " \(placemark.neighborhood ?? "")"
            address += " \(placemark.state ?? "")"
//            address += " \(placemark.region ?? "")"
            address += " \(placemark.zipCode ?? "")"
            address += " \(placemark.country ?? "")"
            name = placemark.name ?? ""
            print(#function, name, address)
        }
    }
    */
    /*
    func convertCoordinateToInfo(_ location: CLLocation) async {
        let request = MKReverseGeocodingRequest(location: location)
        do {
            guard let item = try await request?.mapItems.first else { return }
            let pm = item.placemark

            address = pm.thoroughfare ?? ""
            address += " \(pm.subThoroughfare ?? "")"
            address += " \(pm.locality ?? "")"
            address += " \(pm.subLocality ?? "")"
            address += " \(pm.administrativeArea ?? "")"
            address += " \(pm.postalCode ?? "")"
            address += " \(pm.country ?? "")"
            name = item.name ?? ""
            print(#function, name, address)
        } catch {
            print(#function, error)
        }
    }
    */
    
    func convertCoordinateToInfo(_ location: CLLocation) async {
        guard let request = MKReverseGeocodingRequest(location: location) else { return }
        do {
            guard let item = try await request.mapItems.first else { return }

            let addressRep = item.address
            address = addressRep?.fullAddress ?? ""
            name = item.name ?? ""
            print(#function, name, address)
        } catch {
            print(#function, error)
        }
    }


}
