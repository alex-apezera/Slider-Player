//
//  PrimaryDetailsView.swift
//  Weathered
//
//  First borrowed from christian on 8/28/23.
//

import SwiftUI
import CoreLocation

struct PrimaryDetailsView: View {
    let weatherData: WeatherData
    let fontDesign: Font.Design
    let timeZone: TimeZone

    var body: some View {
        VStack(spacing: 5) {
 
            // Location Name
            Text(weatherData.location.name)
                .font(.title)
                .bold()
                .lineLimit(1)
                .padding(.top, 25)

            // Region Name
            Text("\(weatherData.location.region), \(weatherData.location.country)")
                .font(.headline)
                .opacity(0.6)
                .lineLimit(1)

            // Current Temperature
            Text("\(Int(weatherData.current.tempC))°C")
                .font(.system(size: 80))
            
            // Date, Time
            Text(weatherData.current.lastUpdated.getDate(localTimeZone: timeZone))
                .font(.title3)
                .bold()
                .opacity(0.8)
            Text("\(timeZone)")
                .font(.footnote)
                .fontWeight(.ultraLight)
            
            // Location info
            let latitude = weatherData.location.lat .formatted(.number.precision(.fractionLength(3)))
            let longitude = weatherData.location.lon .formatted(.number.precision(.fractionLength(3)))
            HStack {
                Text("\(.latitude): \(latitude)  \(.longitude): \(longitude)")
                ElevationView(coordinate: CLLocationCoordinate2D(latitude: weatherData.location.lat, longitude: weatherData.location.lon))
            }
            .font(.footnote)
            .fontWeight(.ultraLight)
            .padding(.bottom, 25)
        }
        .foregroundStyle(.white)
        .fontDesign(fontDesign)
        .shadow(radius: 5)
    }
}
