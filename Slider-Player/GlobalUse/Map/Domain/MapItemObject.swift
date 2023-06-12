//
//  MapItemObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.06.2023.
//

import SwiftUI
import CoreLocation

class MapItemObject{
    var coordinates: CLLocationCoordinate2D
    var title: String
    var address: String
    
    init(coordinates: CLLocationCoordinate2D, title: String, address: String) {
            self.coordinates = coordinates
            self.title = title
            self.address = address
        }
}
