//
//  FetchApiData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 03.08.2024.
//

import Foundation
import CoreLocation

extension WeatherInfo {
    
    func fetchApiData(from coordinate: CLLocationCoordinate2D) {
        let decoder = JSONDecoder()
        /// Replace this string with my  API key  from the provided by openweathermap.org.
        let apiKey = "f7ff49543a18b77a8d3cad485e00850a"
        let place = placeTitle.isEmpty ?  "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)" : "q=\(placeTitle)"

        let weatherUrlString = "https://api.openweathermap.org/data/2.5/weather?\(place)&appid=\(apiKey)&units=metric&lang=\(locale)"
 
        let forecastUrlString = "https://api.openweathermap.org/data/2.5/forecast?\(place)&appid=\(apiKey)&units=metric&lang=\(locale)"

        guard let forecastUrl = URL(string: forecastUrlString) else {
            print(#function, "Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: forecastUrl) { data, _, error in
            guard let data else {
                print(#function, "Forecast session failed: ", error as Any)
                return
            }
            do {
                forecastResponse = try decoder.decode(ForecastApiResponse.self, from: data)
            } catch {
                print(#function, error.localizedDescription)
            }
        }.resume()

        guard let weatherUrl = URL(string: weatherUrlString) else {
            print(#function, "Invalid weather URL")
            return
        }
        
        URLSession.shared.dataTask(with: weatherUrl) { data, _, error in
            guard let data else {
                print(#function, "Weather session failed: ", error as Any)
                return
            }
            do {
                weatherResponse = try decoder.decode(WeatherApiResponse.self, from: data)
            } catch {
                print(#function, error.localizedDescription)
            }
        }.resume()

    }
}
