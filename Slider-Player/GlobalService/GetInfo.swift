//
//  GetInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.04.2024.
//
//MARK: - Convert Coordinates of Point to Location Name and Address

import SwiftUI
import CoreLocation

struct GetInfo {
    @Binding var name: String
    @Binding var address: String
    
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
}
