//
//  RegionModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.02.2024.
//

import SwiftUI
import MapKit

class RegionModel: ObservableObject {
    @Published var regionItems = [RegionItem]()
    
    init() {
        let moscow = RegionItem(regionCity: .moscow, regionName: "Moscow")
        let boston = RegionItem(regionCity: .boston, regionName: "Boston")
        let northShore = RegionItem(regionCity: .northShore, regionName: "North Shore")
        let newYork = RegionItem(regionCity: .newYork, regionName: "New York")
        let sanFrancisco = RegionItem(regionCity: .sanFrancisco, regionName: "San Francisco")
        let london = RegionItem(regionCity: .london, regionName: "London")
        let bangkock = RegionItem(regionCity: .bangkock, regionName: "Bangkock")
        let vien = RegionItem(regionCity: .vien, regionName: "Vien")
        let peterburg = RegionItem(regionCity: .peterburg, regionName: "Saint Petersburg")
        regionItems = [moscow, peterburg, boston, northShore, newYork, sanFrancisco, london, vien, bangkock]
    }
}
