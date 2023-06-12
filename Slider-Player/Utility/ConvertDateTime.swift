//
//  ConvertDateTime.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 14.09.2024.
//

import Foundation

//MARK: - Date Formatter

func dateString(for date: Date?) -> String {
    var dateFormatted = ""
    
    // Create Date
    if let date {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Set Locale
        dateFormatter.locale = Locale(identifier: "ru-RU")

        // Convert Date to String
        dateFormatted = dateFormatter.string(from: date) // January 23, 2023 at 9:40 PM
    }
    return dateFormatted
}

//MARK: - Convert Unix Time to Date and Time

func convertUnixTime( _ dt: Int, format: String, locale: String) -> String {
        let timeResult = Double(dt)
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = format
//        dateFormatter.dateFormat = "d MMMM yyyy, hh:mm a" // OR " EEEE, dd-MM-yyyy"
        return dateFormatter.string(from: date)
}
