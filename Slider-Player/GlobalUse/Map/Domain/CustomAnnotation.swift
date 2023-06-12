//
//  CustomAnnotation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.06.2023.
//

import Foundation
import CoreLocation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
        
    ) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
