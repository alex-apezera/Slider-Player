//
//  UserSettings.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.03.2023.
//

import SwiftUI

class UserAutentification: ObservableObject {
        
    //MARK: - Autentification Details
        
    @AppStorage("profileImageIsEmpty") var profileImageIsEmpty: Bool = true
    @AppStorage("userLogin") var userLogin: String = ""
    @AppStorage("userPassword") var userPassword: String = "2587"
    
    // MARK: - Profile Details
    
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("aboutMe") var aboutMe: String = ""
}

class UserSettings: ObservableObject {
    
    //MARK: - User Settings Detail
    
    @AppStorage("username") var username: String  = ""
    @AppStorage("isAccountPrivate") var isPrivate: Bool = false
    @AppStorage("ringtone") var ringtone: String = "ding"
    @AppStorage("pianoKeyboards") var pianoKeyboards = 1
    @AppStorage("pianoKeys") var pianoKeys = 25
    @AppStorage("initialColumns") var initialColumns: Int  = 3
    @AppStorage("gridMode") var gridMode:  String = .enFlexible
    @AppStorage("localeItem") var localeItem: String = .russian
    @AppStorage("guidanceSite") var guidanceSite: String = "https://developer.apple.com/tutorials/"
    @AppStorage("nameSite") var nameSite: String = "applelogo"
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0
    
    let ringtones = ["Chimes", "ding", "Waves"]
    
    let compressionQualities: [Double] = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
    
    let keyboardNums = [1, 2, 3]
    
    let keysNumber = [18, 25, 30]
    
    let gridColumns = [1, 2, 3, 4, 5, 6, 7, 8]
            
    let localeItems = [String.russian, .english]
        
    var gridModes: [String] { localeRu ? [.ruFlexible, .ruAdaptive] : [.enFlexible, .enAdaptive] }
    
    let guideSites = [
        "https://developer.apple.com/tutorials/",
        "https://www.simpleswiftguide.com/",
        "https://swiftbook.org/",
        "https://openweathermap.org/",
        "https://www.weatherapi.com/",
        "https://open-elevation.com/",
        "http://www.apple.com/itunes/",
        "https://earthquake.usgs.gov/earthquakes/",
        "https://newsapi.org/"
    ]
    
    let guideIcons = ["applelogo", "swift", "book", "thermometer.sun.fill", "cloud.sun.rain.fill", "arrow.up.square", "music.note.list", "exclamationmark.triangle.fill", "newspaper"]
    
    public func nameSite(for icon: String) -> some View {
        switch icon {
        case guideIcons[0]: Text(" Apple")
        case guideIcons[1]: Text(" Swift Guide")
        case guideIcons[2]: Text(" Swift Book")
        case guideIcons[3]: Text(" OpenWeather")
        case guideIcons[4]: Text(" WeatherApi")
        case guideIcons[5]: Text(" Elevation")
        case guideIcons[6]: Text(" iTunes")
        case guideIcons[7]: Text(" Quakes")
        case guideIcons[8]: Text(" News")
        default: Text("")
        }
    }
}
