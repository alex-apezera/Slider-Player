//
//  User.swift
//  Weathered
//
//  Created by christian on 8/7/23.
//

//import Foundation
import SwiftUI
import SwiftData

@available(iOS 17, *)
@Model
final class FavoritePlace {
    var id: UUID
    var name: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    
    init(id: UUID = UUID(),
         name: String,
         region: String,
         country: String,
         latitude: Double,
         longitude: Double) {
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
