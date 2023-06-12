//
//  weatherContent.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.08.2024.
//

import SwiftUI
import CoreLocation

extension WeatherInfo {
    
    //MARK: - Current weather view
    @ViewBuilder var weatherContent: some View {
        VStack{
            if let weatherResponse {
                Text("\(Int(weatherResponse.main.temp))°C")
                    .font(.custom("", size: 32)).padding(.top, 20)
                Text(weatherResponse.name).font(.title2).bold()
                Text(convertUnixTime(weatherResponse.dt, dateFormat: .dateFormatDayDateHour, localTimeZone: timeZone ?? .current)).font(.callout).bold()
                Text("\(timeZone ?? .current)").font(.footnote).fontWeight(.ultraLight).padding(.bottom, 5)
                Text(weatherResponse.weather.first?.description ?? "").font(.body).bold()
                
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    //MARK: - Table items
                    HStack(spacing: space) {
                        itemView(size: cloudsCell, item: Text(String.clouds))
                        itemView(size: rainCell, item: Text(String.precipitation))
                        itemView(size: windCell, item: Text(String.wind))
                        itemView(size: humidCell, item: Text(String.humidity))
                        itemView(size: pressCell, item: Text(String.pressure))
                        itemView(size: sunriseCell, item: Text(String.sunrise))
                        itemView(size: sunsetCell, item: Text(String.sunset))
                   }
                    //MARK: - Cirrent weather items
                    HStack(spacing: space) {
                        cloudinessInfo(weatherResponse.clouds.all)
                        rainInfo(weatherResponse.rain?.the1H ?? 0)
                        windInfo(weatherResponse.wind.speed)
                        humidityInfo(weatherResponse.main.humidity)
                        pressureInfo(weatherResponse.main.pressure)
                        sunriseInfo(weatherResponse.sys.sunrise)
                        sunsetInfo(weatherResponse.sys.sunset)
                    }
                }
                .onAppear {
                    let coordinate = CLLocation(latitude: weatherResponse.coord.lat, longitude: weatherResponse.coord.lon)
                    LocalTimeZone(timeZone: $timeZone).getTimeZone(coordinate: coordinate)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                Divider().padding(.bottom, 10)
            } else {
                ProgressView()
            }
        }//VStack
        .foregroundStyle(.gray)
    }
}
