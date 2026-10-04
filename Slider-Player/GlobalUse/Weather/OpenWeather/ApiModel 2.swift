//
//  ApiModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.08.2024.
//
// From OpenWeather API
//MARK: - API data model

import Foundation

//MARK: - Weather API model (current day)

struct WeatherApiResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let rain: Rain1H?
    let clouds: Clouds
    let dt: Int
    let sys: SysInfo
    let name: String
}

//MARK: - This only for WearAPI
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Coord: Codable {
    let lat, lon: Double
}

struct Rain1H: Codable {
    let the1H: Double
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

struct SysInfo: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

//MARK: - Forecast API model (5 days)

struct ForecastApiResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ListResponse]
    let city: City
}

//MARK: - This only for ForecastAPI

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct ListResponse: Identifiable, Codable {
    let id = UUID()
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain3H?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys, rain
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain3H: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

//MARK: - This common for WeatherAPI and ForecastAPI

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Clouds: Codable {
    let all: Int
}

struct Weather: Codable {
   let id: Int
   let main: String
   let description: String
   let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
}
