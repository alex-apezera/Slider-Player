//
//  ElevationData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.10.2024.
//

import Foundation

/*
/// Get API data from 'open-elevation.com'
struct ElevationData: Codable {
    let results: [ApiData]
}

struct ApiData: Codable {
    let latitude: Double
    let longitude: Double
    let elevation: Double
}
*/

/// Data model OpenTopoData
struct ElevationData: Decodable {
    let results: [ApiData]
    let status: String?
}

struct ApiData: Decodable {
    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }
    let elevation: Double?   /// null вне покрытия DEM
    let location: Location
    let dataset: String?
}


