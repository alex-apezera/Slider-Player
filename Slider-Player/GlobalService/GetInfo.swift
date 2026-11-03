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

    @MainActor
    func convertCoordinateToInfo(_ location: CLLocation) async {
        guard let request = MKReverseGeocodingRequest(location: location) else { return }
        do {
            guard let item = try await request.mapItems.first else { return }
            let addressRep = item.address
            address = addressRep?.fullAddress ?? ""
            name = item.name ?? ""
            print("🆔", #function, name, address)
        } catch {
            print(#function, error)
        }
    }


}
