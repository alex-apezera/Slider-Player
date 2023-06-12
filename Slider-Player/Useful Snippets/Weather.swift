//
//  Weather.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.04.2024.
//
/*
import SwiftUI
import WeatherKit

struct WeatherView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: weather.symbolName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
            
            Text(String(format: "%.0f", weather.temperature) + "°C")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Text(weather.condition.uppercased())
                .foregroundColor(.white)
                .font(.body)
            
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "humidity.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                    
                    Text(String(format: "%.0f", weather.humidity) + "%")
                        .foregroundColor(.white)
                        .font(.body)
                }
            }
        }
        .padding(.top, 50)
    }
}

struct Weather {
    let temperature: Double
    let condition: String
    let symbolName: String
    let humidity: Double
    let isDaylight: Bool

    static func empty() -> Weather {
        Weather(temperature: 0,
                condition: "",
                symbolName: "",
                humidity: 0,
                isDaylight: false)
    }
}

class WeatherViewModel: ObservableObject {

    let service = WeatherService()
    let locationManager = LocationManager()

    @Published var currentWeather: Weather = .empty()
    
    func getWeather() async {
        do {
            guard let currentLocation = locationManager.lastLocation else {
                return
            }
            
            let weather = try await service.weather(for: currentLocation)
            
            self.currentWeather = Weather(temperature: weather.currentWeather.temperature.value,
                                          condition: weather.currentWeather.condition.rawValue,
                                          symbolName: weather.currentWeather.symbolName,
                                          humidity: weather.currentWeather.humidity,
                                          isDaylight: weather.currentWeather.isDaylight)
        } catch {
            print(error.localizedDescription)
        }
    }
}
*/

//MARK: - Weather driver for Apple development team

 // Use in App
 /*
 import WeatherKit
 
 @StateObject var weatherViewModel = WeatherViewModel()
 
             WeatherView(weather: weatherViewModel.currentWeather)

            weatherViewModel.currentWeather.isDaylight ? //->  .background()

        .onAppear {
            Task {
                await weatherViewModel.getWeather() // asume WeatherKit
            }
        }

*/
