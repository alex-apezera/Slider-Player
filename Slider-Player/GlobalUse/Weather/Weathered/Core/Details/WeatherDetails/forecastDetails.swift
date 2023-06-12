//
//  ForecastDetails.swift
//  Weathered
//
//  Created by Алексей Езерский on 11.09.2024.
//

import SwiftUI
extension SecondaryDetailsView {
    
    func forecastDetails(for forecastDay:  Forecastday) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Spacer()
                WeatherDetailGridItem(metric: .maxTemp, value: String("\(forecastDay.day.maxtempC)°C"))
                WeatherDetailGridItem(metric: .minTemp, value: String("\(forecastDay.day.mintempC)°C"))
                WeatherDetailGridItem(metric: .maxWind, value: String("\(forecastDay.day.maxwindKph) " + .kph))
                WeatherDetailGridItem(metric: .totalPrecpt, value: String("\(forecastDay.day.totalprecipMm) " + .mm))
                WeatherDetailGridItem(metric: .rainChance, value: String("\(forecastDay.day.dailyChanceOfRain)%"))
                WeatherDetailGridItem(metric: .totalSnow, value: String("\(forecastDay.day.totalsnowCM) " + .sm))
                WeatherDetailGridItem(metric: .snowChance, value: String("\(forecastDay.day.dailyChanceOfSnow)%"))
                WeatherDetailGridItem(metric: .humidity, value: String("\(forecastDay.day.avghumidity)%"))
                WeatherDetailGridItem(metric: .visibility, value: String("\(forecastDay.day.avgvisKM) " + .km))
                WeatherDetailGridItem(metric: .uvIndex, value: String(forecastDay.day.uv))
                WeatherDetailGridItem(metric: .sunrise, value: forecastDay.astro.sunrise)
                WeatherDetailGridItem(metric: .sunset, value: forecastDay.astro.sunset)
                WeatherDetailGridItem(metric: .moonrise, value: forecastDay.astro.moonrise)
                WeatherDetailGridItem(metric: .moonset, value: forecastDay.astro.moonset)
                Spacer()
            }//HStack
        }//Scroll
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

