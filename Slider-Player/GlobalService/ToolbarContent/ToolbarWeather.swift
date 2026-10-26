//
//  ToolbarWeather.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 16.08.2024.
//

//MARK: - Weather toolbar

import SwiftUI

struct ToolbarWeather {
    @Binding var openWeatherView: Bool
    @Binding var weatherApiView: Bool
    @ToolbarContentBuilder
    var weatherButtons: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            WeatherButton(icon: "openweathermap") {
                openWeatherView.toggle()
            }
            WeatherButton(icon: "weatherapi") {
                weatherApiView.toggle()
            }

        }
    }
    
}
