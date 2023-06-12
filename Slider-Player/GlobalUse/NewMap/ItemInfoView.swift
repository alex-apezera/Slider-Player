//
//  ItemInfoView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 24.01.2024.
//

//MARK: - LookAroundPreview + placeName, route, weather

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct ItemInfoView: View {
    
    let selectedResult: MKMapItem
    let route: MKRoute?
    
    @State var locationName: String = ""
    @State var locationAddress: String = ""
    @State var location2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    @State var lookAroundScene: MKLookAroundScene?
    @State var showPlaceInfo = false
    @State var showWeatherInfo = false
    @State var showOpenWeatherInfo = false

    var travelTime: String? {
        guard let route else {return nil}
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var distance: String? {
        guard let route else {return nil}
        return String(format: "%.1f", route.distance / 1000)
    }
        
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    
                    selectedLocationInfo
                    
                    routeInfo
                    
                    sidebarInfo
                }
                .lineLimit(2)
                .font(iPadDevice ? .body : .caption)
                .foregroundStyle(.white)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, iPadDevice ? 20 : 7)
                .padding(.top, 15)
            }
            .onAppear {
                getPlacemarkInfo(mapItem: selectedResult)
                getLookAroundScene(mapItem: selectedResult)
            }
            .onChange(of: selectedResult) { newValue in
                getPlacemarkInfo(mapItem: newValue)
                getLookAroundScene(mapItem: newValue)
            }
            .popover(isPresented: $showPlaceInfo, arrowEdge: .bottom) {
                placeInfo
            }
            .sheet(isPresented: $showOpenWeatherInfo) {
                weatherInfo(for: location2D)
            }
            .sheet(isPresented: $showWeatherInfo) {
                WeatherApiView(coordinates: String(location2D.latitude) + "," + String(location2D.longitude), viewingDetails: $showWeatherInfo).environmentObject(WeatherViewModel())
            }
    }
}

