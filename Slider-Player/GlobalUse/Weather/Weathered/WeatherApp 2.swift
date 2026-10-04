//
//  WeatherApp.swift
//  Weathered
//
// First borrowed from christian on 3/25/23.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct WeatherApp: View {
    @State var viewingDetails: Bool = false
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var locationVM = LocationViewModel()
    
    let modelContainer: ModelContainer
    init() {
        do {
            modelContainer = try ModelContainer(for: FavoritePlace.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some View {
        WeatherApiView(viewingDetails: $viewingDetails)
            .environmentObject(weatherVM)
            .environmentObject(locationVM)
            .modelContainer(for: FavoritePlace.self)
            .navigationModifier("WeatherApi.com")
    }
}
