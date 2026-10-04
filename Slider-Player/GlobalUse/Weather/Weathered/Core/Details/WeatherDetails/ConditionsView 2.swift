//
//  ConditionsView.swift
//  Weathered
//
//  First borrowed from christian on 3/25/23.

//MARK: - Weather view with conditions and time zone

import SwiftUI
import CoreLocation

struct ConditionsView: View {
    @Binding var viewingDetails: Bool
    let weatherData: WeatherData
    let fontDesign: Font.Design
        
    @State private var time = 0.1
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    @State private var showingControls = false
    
    @State var timeZone: TimeZone?

    let residueType =  Storm.Contents.none
    let resiudeStrength = 0.0
    
    var thunderStorm: Bool {
        switch weatherData.current.condition.code {
        case 1273, 1276, 1279, 1282:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        let coordinate = CLLocation(latitude: weatherData.location.lat, longitude: weatherData.location.lon)

        ZStack {
            SkyWeather(weatherData: weatherData)
            
            ResidueView(type: residueType, strength: resiudeStrength)
                .frame(height: 62)
                .offset(y: -65)
                .zIndex(1)
            
            // Thunder before top layer
            if thunderStorm{
                LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
            }
            
            // Weather Details (top layer)
            VStack(alignment: .center, spacing: 0) {
                PrimaryDetailsView(weatherData: weatherData, fontDesign: fontDesign, timeZone: timeZone ?? .current)
                SecondaryDetailsView(weatherData: weatherData, timeZone: timeZone ?? .current, tintColor: backgroundTopStops.interpolated(amount: time))
            }
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .shadow(color: .black.opacity(0.6), radius: 6, y: 4)
            .onTapGesture(count: 2) {// act with top layer
                viewingDetails = false
            }
            .keyboardShortcut("q", modifiers: [.control])
            .onAppear {
                LocalTimeZone(timeZone: $timeZone).getTimeZone(coordinate: coordinate)
            }
        }
    }
}
