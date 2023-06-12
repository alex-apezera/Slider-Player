//
//  forecastContent.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.09.2024.
//

import SwiftUI
extension WeatherInfo {
    
    //MARK: - Forecast 5 days view
    @ViewBuilder var forecastContent: some View {
        if let forecastResponse {
            Text(String.forecast5Days)
                .foregroundStyle(.gray)
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                
                //MARK: - Table items
                HStack(spacing: space) {
                    itemView(size: dayCell, item: Text(String.dayCell))
                    itemView(size: tempCell, item: Text(String.tempCell))
                    itemView(size: descCell, item: Text(String.description))
                    itemView(size: cloudsCell, item: Text(String.clouds))
                    itemView(size: rainCell, item: Text(String.precipMm))
                    itemView(size: windCell, item: Text(String.wind))
                    itemView(size: humidCell, item: Text(String.humidity))
                    itemView(size: pressCell, item: Text(String.pressure))
               }
                //MARK: - Forecast items
                ScrollView(showsIndicators: false) {
                    ForEach(forecastResponse.list) { response in
                        HStack(spacing: space) {
                            itemView(size: dayCell, item: Text(convertUnixTime(response.dt, dateFormat: .dateFormatDayHour, localTimeZone: timeZone ?? .current)))
                            temperatueInfo(response.main.temp)
                            itemView(size: descCell, item: Text(response.weather.first?.description ?? ""))
                            cloudinessInfo(response.clouds.all)
                            rainInfo(response.rain?.the3H ?? 0)
                            windInfo(response.wind.speed)
                            humidityInfo(response.main.humidity)
                            pressureInfo(response.main.pressure)
                        }
                    }
                }
            }
            .foregroundStyle(.gray)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .frame(height: 250)
            Divider().padding(.bottom, 10)
        } else {
            ProgressView()
        }
    }
}
