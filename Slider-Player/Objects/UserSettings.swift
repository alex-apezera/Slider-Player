//
//  UserSettings.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.03.2023.
//
// Данные для Авторизации и Настроек Пользователя
// Данные по метоположению и дате объектов их фотобиблиотеки
// Использование UserDefaults для хранения переменных в памяти

import Foundation
import SwiftUI
//import Combine

class UserAutentification: ObservableObject {
        
    //MARK: - Autentificsation Details
        
    // State of userProfileImage
    @Published var profileImageIsEmpty: Bool {
        didSet { UserDefaults.standard.set(profileImageIsEmpty, forKey: "profileImageIsEmpty") }
    }
    // Login-Password
    @Published var userLogin: String {
        didSet { UserDefaults.standard.set(userLogin, forKey: "userLogin") }
    }
    @Published var userPassword: String {
        didSet { UserDefaults.standard.set(userPassword, forKey: "userPassword") }
    }
    
    // MARK: - Profile Details
    
    @Published var firstName: String {
        didSet { UserDefaults.standard.set(firstName, forKey: "firstName") }
    }
    @Published var lastName: String {
        didSet { UserDefaults.standard.set(lastName, forKey: "lastName") }
    }
    @Published var aboutMe: String {
        didSet { UserDefaults.standard.set(aboutMe, forKey: "aboutMe") }
    }
    //Retrieve Objects from UserDefaults
    init() {
        self.userLogin = UserDefaults.standard.object(forKey: "userLogin") as? String ?? ""
        self.userPassword = UserDefaults.standard.object(forKey: "userPassword") as? String ?? "2587"
        self.profileImageIsEmpty = UserDefaults.standard.object(forKey: "profileImageIsEmpty") as? Bool ?? true
        self.firstName = UserDefaults.standard.object(forKey: "firstName") as? String ?? ""
        self.lastName = UserDefaults.standard.object(forKey: "lastName") as? String ?? ""
        self.aboutMe = UserDefaults.standard.object(forKey: "aboutMe") as? String ?? ""
    }
}

class UserSettings: ObservableObject {
    
    //MARK: - User Settings Detail
    
    @Published var username: String {
        didSet { UserDefaults.standard.set(username, forKey: "username") }
    }
    @Published var isPrivate: Bool {
        didSet { UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate") }
    }
    @Published var ringtone: String {
        didSet { UserDefaults.standard.set(ringtone, forKey: "ringtone") }
    }
    public var ringtones = ["Chimes", "ding", "Waves"]

    // Tutorials and Guidance Sites
    @Published var guidanceSite: String {
        didSet { UserDefaults.standard.set(guidanceSite, forKey: "guidanceSite") }
    }
    @Published var nameSite: String {
        didSet { UserDefaults.standard.set(nameSite, forKey: "nameSite")}
    }
    public var guidanceSites = [
        "https://developer.apple.com/tutorials/",
        "https://www.simpleswiftguide.com/",
        "https://swiftbook.org/"]
    
    public var nameSites = ["applelogo", "swift", "book"]
    
    // Retrieve Objects from UserDefaults
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? false
        self.ringtone = UserDefaults.standard.object(forKey: "ringtone") as? String ?? "ding"
        self.guidanceSite = UserDefaults.standard.object(forKey: "guidanceSite") as? String ?? "https://developer.apple.com/tutorials/"
        self.nameSite = UserDefaults.standard.object(forKey: "nameSite") as? String ?? "applelogo"
    }
}

//MARK: User placemark data

class UserPlacemarkData: ObservableObject {
    
    @Published var placemarkName: String {
        didSet {UserDefaults.standard.set(placemarkName, forKey: "placemarkName")}
    }
    @Published var captureDate: String {
        didSet {UserDefaults.standard.set(captureDate, forKey: "captureDate")}
    }
    @Published var placemarkCountry: String {
        didSet {UserDefaults.standard.set(placemarkCountry, forKey: "placemarkCountry")}
    }
    @Published var placemarkCity: String {
        didSet {UserDefaults.standard.set(placemarkCity, forKey: "placemarkCity")}
    }
    @Published var placemarkStreet: String {
        didSet {UserDefaults.standard.set(placemarkStreet, forKey: "placemarkStreet")}
    }
    @Published var placemarkPostalCode: String {
        didSet {UserDefaults.standard.set(placemarkPostalCode, forKey: "placemarkPostalCode")}
    }
    init() {
        self.placemarkName = UserDefaults.standard.object(forKey: "placemarkName") as? String ?? "Home"
        self.captureDate = UserDefaults.standard.object(forKey: "captureDate") as? String ?? "6 Jun 2023"
        self.placemarkCountry = UserDefaults.standard.object(forKey: "placemarkCountry") as? String ?? "Russia"
        self.placemarkCity = UserDefaults.standard.object(forKey: "placemarkCity") as? String ?? "Moscow"
        self.placemarkStreet = UserDefaults.standard.object(forKey: "placemarkStreet") as? String ?? "3rd Frunzenskaya street, 6"
        self.placemarkPostalCode = UserDefaults.standard.object(forKey: "placemarkPostalCode") as? String ?? "119270"

    }
}
