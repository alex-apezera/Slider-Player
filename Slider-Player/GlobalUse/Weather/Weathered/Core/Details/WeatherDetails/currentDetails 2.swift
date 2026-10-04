//
//  CurrentDetails.swift
//  Weathered
//
//  Created by Алексей Езерский on 11.09.2024.
//

import SwiftUI
extension SecondaryDetailsView {
    
    var currentDetails: some View {
        Group {
            WeatherDetailRowView(metric: .feelsLike, unit: "°C", value: weatherData.current.feelslikeC)
            WeatherDetailRowView(metric: .clouds, unit: "%", value: Double(weatherData.current.cloud))
            WeatherDetailRowView(metric: "\(String.wind) \(weatherData.current.windDir)", unit: .kph, value: weatherData.current.windKph)
            WeatherDetailRowView(metric: .precipitation, unit: .mm, value: weatherData.current.precipMm)
            WeatherDetailRowView(metric: .pressure, unit: .mb, value: weatherData.current.pressureMB)
            WeatherDetailRowView(metric: .humidity, unit: "%", value: Double(weatherData.current.humidity))
            WeatherDetailRowView(metric: .visibility, unit: .km,
                                 value: weatherData.current.visKM)
            WeatherDetailRowView(metric: .uvIndex, unit: "", value: weatherData.current.uv)
        }//Group
    }
}
