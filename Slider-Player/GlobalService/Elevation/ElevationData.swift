//
//  ElevationData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.10.2024.
//

import Foundation

struct ElevationData: Codable {
    let results: [ApiData]
}

struct ApiData: Codable {
    let latitude: Double
    let longitude: Double
    let elevation: Double
}
