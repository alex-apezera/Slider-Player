//
//  WeatherViewModel.swift
//  Weathered
//
//  First borrowed from christian on 7/24/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    var query = ""
    let weatherService = WeatherService()
    
    func fetchWeatherData() {
        weatherService.fetchWeatherData(for: query) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherData = data
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
