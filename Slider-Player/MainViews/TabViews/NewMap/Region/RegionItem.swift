//
//  RegionItem.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.02.2024.
//

//MARK: - Item of region

import SwiftUI
import MapKit

struct RegionItem: Identifiable {
    let id = UUID()
    let regionCity: MKCoordinateRegion?
    let regionName: String
}
