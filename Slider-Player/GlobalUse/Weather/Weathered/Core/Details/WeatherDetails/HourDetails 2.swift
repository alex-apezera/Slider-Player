//
//  HourDetails.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.09.2024.
//

import SwiftUI
    
    struct HourDetails: View {
        let dayResponse: Forecastday
        let timeZone: TimeZone
        @Binding var hourlyForecast: Bool
        
        // Day + hour format
        var dayHour: String = "EE H"

        var body: some View {
            
            Divider().colorInvert().padding(.leading, 15).padding(.trailing, 15).padding(.top, 10).frame(height: 2)
            
            ForEach(dayResponse.hour) { hourResponse in
                
                Text("\(convertUnixTime(hourResponse.timeEpoch, dateFormat: dayHour, localTimeZone: timeZone)):  \(hourResponse.condition.text)").textModifier
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Spacer()
                        WeatherDetailGridItem(metric: .temperature, value: String("\(hourResponse.tempC)°C"))
                        WeatherDetailGridItem(metric: .clouds, value: String("\(hourResponse.cloud)%"))
                        WeatherDetailGridItem(metric: "\(String.wind)  \(hourResponse.windDir)", value: String("\(hourResponse.windKph) kph"))
                        WeatherDetailGridItem(metric: .pressure, value: String("\(hourResponse.pressureMB) mb"))
                        WeatherDetailGridItem(metric: .humidity, value: String("\(hourResponse.humidity)%"))
                        WeatherDetailGridItem(metric: .precipMm, value: String("\(hourResponse.precipMm) mm"))
                        WeatherDetailGridItem(metric: .rainChance, value: String("\(hourResponse.chanceOfRain)%"))
                        WeatherDetailGridItem(metric: .snowCm, value: String("\(hourResponse.snowCm) cm"))
                        WeatherDetailGridItem(metric: .snowChance, value: String("\(hourResponse.chanceOfSnow)%"))
                        WeatherDetailGridItem(metric: .visibility, value: String("\(hourResponse.visKM) km"))
                        Spacer()
                    }//HStack
                    .onTapGesture {
                        hourlyForecast = false
                    }
                }//SCrollView
                .padding(.leading, 15)
                .padding(.trailing, 15)
            }//ForEach - hour
            Divider().colorInvert().padding(.leading, 15).padding(.trailing, 15).padding(.bottom, 10).frame(height: 2)
        }
    }
