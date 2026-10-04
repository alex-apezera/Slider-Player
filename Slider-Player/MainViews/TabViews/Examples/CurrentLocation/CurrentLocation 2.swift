//
//  CurrentLocation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.06.2023.
//
// Show current location with current weather (if access granted)

import SwiftUI
import MapKit

struct CurrentLocation: View {
    
    @ObservedObject var locationManager = LocationManager()
    @AppStorage("lightsOn") var lightsOn: Bool = false
    @State var openWeatherView = false
    @State var weatherApiView = false
    let userPoint = CurrentPoint()
    @State private var region = MKCoordinateRegion()
    @State var name = ""
    @State var address = ""
    
    func getCurrentLocationData() {
        locationManager.requestLocation()
        let location = userPoint.currentLocation
        let getInfo = GetInfo(name: $name, address: $address)
        getInfo.convertCoordinateToInfo(location)
    }
    
    var body: some View {
        ZStack {
            if let coordinate = locationManager.location {
                
                VStack {// 1
                    CurrentPlaceMap(coordinate: coordinate)
                        .ignoresSafeArea(.container)
                    VStack {// 2
                        //MARK: - Timeline
                        TimelineView(.everyMinute) { context in
                            Text(name).font(.title3).bold().foregroundStyle(.primary)
                            Text(address)
                            Text(context.date.formatted(customDateStyle())).foregroundStyle(.secondary).bold()
                            Text(coord2String(coordinate: userPoint.currentCoordinate)).foregroundStyle(.tertiary)
                            Text("\(.altitude): \(String(format: "%.0f", locationManager.lastLocation?.altitude ?? 0))m").foregroundStyle(.tertiary)
                                .padding(.bottom, 10)
                        }
                    }//VStack 2
                    .padding(5)
                }//VStack 1
                
                if openWeatherView {
                    weatherInfo(for: coordinate)
                }
                if weatherApiView {
                    WeatherApiView(coordinates: String(coordinate.latitude) + "," + String(coordinate.longitude), viewingDetails: $weatherApiView).environmentObject(WeatherViewModel())
                }
            }
        }
        .onAppear {getCurrentLocationData()}
        .toolbar { ToolbarWeather(openWeatherView: $openWeatherView, weatherApiView: $weatherApiView).weatherButtons() }
        .navigationModifier(String.currentLocation)
        .background(LinearGradient(colors:                                        lightsOn ? [.cyan.opacity(0.1), .blue.opacity(0.5)] : [.gray.opacity(0.1), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
    }
}
