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
    @ToolbarContentBuilder func weatherButtons() -> some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            HStack(spacing: 20) {
                
                Button {
                   openWeatherView.toggle()
                } label: {
                    Image("openweathermap").resizable()
                }
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(maxWidth: 28)
                
                Button {
                    weatherApiView.toggle() 
                } label: {
                    Image("weatherapi").resizable()
                }
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(maxWidth: 36)
            }
        }
    }
}
