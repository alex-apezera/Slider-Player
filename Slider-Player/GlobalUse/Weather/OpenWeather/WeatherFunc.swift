//
//  WeatherFunc.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 24.08.2024.
//

import SwiftUI
extension WeatherInfo {

//MARK: - Rendering themperatue
    @ViewBuilder func temperatueInfo(_ temp: Double) -> some View {
        itemView(size: tempCell, item: HStack {
            tempIcon(for: temp)
            Spacer()
            Text("\(Int(temp))°C").bold()
        })
    }

//MARK: - Rendering cloudiness quantity
    @ViewBuilder func cloudinessInfo(_ quantity: Int) -> some View {
        itemView(size: cloudsCell, item: HStack {
            cloudinessIcon(quantity)
            Spacer()
            Text("\(String(quantity))%")
        })
    }
    
//MARK: - Rendering rain quantity
    @ViewBuilder func rainInfo(_ quantity: Double) -> some View {
        itemView(size: rainCell, item: HStack {
            rainIcon(quantity)
            Spacer()
            Text("\(String(format: "%.1f", quantity))\(localeRu ? "мм" : "mm")")
        })
    }
//MARK: - Rendering wind quantity
    @ViewBuilder func windInfo(_ quantity: Double) -> some View {
        itemView(size: windCell, item: HStack {
            windIcon(quantity)
            Spacer()
            Text("\(String(format: "%.1f", quantity))\(localeRu ? " м/с" : " mps")")
        })
    }
//MARK: - Rendering humidity quantity
    @ViewBuilder func humidityInfo(_ quantity: Int) -> some View {
        itemView(size: humidCell, item: HStack {
            humidityIcon(quantity)
            Spacer()
            Text("\(String(quantity))%")
        })
    }
    
//MARK: - Rendering pressure quantity
    @ViewBuilder func pressureInfo(_ quantity: Int) -> some View {
        itemView(size: pressCell, item: HStack {
            pressureIcon(quantity)
            Spacer()
            Text("\(String(format: "%.0f", Double(quantity)))\(localeRu ? "мб" : "mb")")
        })
    }
    //MARK: - Rendering sunrise and sunset
        @ViewBuilder func sunriseInfo(_ timerise: Int) -> some View {
            itemView(size: sunriseCell, item: HStack {
                sunriseIcon()
                Spacer()
                Text(convertUnixTime(timerise, dateFormat: .dateFormatMoon, localTimeZone: timeZone ?? .current))
            })
        }
    //MARK: - Rendering sunrise and sunset
        @ViewBuilder func sunsetInfo(_ timeset: Int) -> some View {
            itemView(size: sunsetCell, item: HStack {
                sunsetIcon()
                Spacer()
                Text(convertUnixTime(timeset, dateFormat: .dateFormatMoon, localTimeZone: timeZone ?? .current))
            })
        }
}
