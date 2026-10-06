//
//  WeatherDetailsView.swift
//  Weathered
//
//  First borrowed from christian on 3/30/23.

//MARK: - Current and forecast details

import SwiftUI

struct SecondaryDetailsView: View {
    let weatherData: WeatherData
    let timeZone: TimeZone
    
    @State var hourlyForecast = false
    @State var hourly = false
    
    // Day format
    var dayOfWeekShort: String = "EE"

    // Background color
    let tintColor: Color
            
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(tintColor.opacity(0.25))
                .foregroundStyle(.ultraThinMaterial)
                .padding(.horizontal, 20)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("\(.now): \(weatherData.current.condition.text)").textModifier
                    
                    currentDetails
                    
                    ForEach(weatherData.forecast.forecastday) { dayResponse in
                        
                        Text("\(convertUnixTime(dayResponse.dateEpoch, dateFormat: dayOfWeekShort, localTimeZone: timeZone)):  \(dayResponse.day.condition.text)").textModifier
                        
                        forecastDetails(for: dayResponse)
                            .onTapGesture {
                                hourlyForecast.toggle()
                            }
                        if hourly {
                            HourDetails(dayResponse: dayResponse, timeZone: timeZone, hourlyForecast: $hourlyForecast)
                        }
                    }//ForEach - day
                }
                .onChange(of: hourlyForecast) { _, newValue in
                    hourly = newValue
                }
                .lineLimit(1)
                .foregroundStyle(.white)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            }//ScrollView
            .padding(.bottom, 15)
            .padding(.top, 10)
        }//ZStack
        .padding(.bottom, 15)
    }//body
}
