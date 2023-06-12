//
//  DateTimeTools.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.09.2024.
//

import Foundation

//MARK: - Date formatter
extension DateComponentsFormatter {
    
    static let abbreviated: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.calendar?.locale = Locale(identifier: locale)
        return formatter
    }()
    
    static let pozitional: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.calendar?.locale = Locale(identifier: locale)
        return formatter
    }()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.calendar?.locale = Locale(identifier: locale)
        return formatter
    }()
}

//MARK: - Conversion String to Date and TimeOfDay
extension String {
    
    func getDate(localTimeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.timeZone = localTimeZone
        dateFormatter.dateStyle = iPadDevice ? .full : .long
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: dateFormatter.date(from: self) ?? Date())
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: dateFormatter.date(from: self) ?? Date())
    }
        
    func calculateTimeOfDay() -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)
            
            if let hour = components.hour, let minute = components.minute {
                let totalMinutes = Double(hour * 60 + minute)
                let totalTimeOfDay = totalMinutes / (24.0 * 60.0)
                return totalTimeOfDay
            }
        }
        
        // Return nil if the string is not in the correct format or if the conversion fails
        return nil
    }
}
//MARK: - Convert Date to String

func dateString(for date: Date?) -> String {

    // Create Date
    if let date {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = iPadDevice ? .full : .long
        dateFormatter.timeStyle = .short

        // Set Locale
        dateFormatter.locale = Locale(identifier: locale)

        // Convert Date to String
        return dateFormatter.string(from: date) // January 23, 2023 at 9:40 PM
    }
    return ""
}

//MARK: - Convert Unix Time to Date and Time

func convertUnixTime(_ dt: Int, dateFormat: String, localTimeZone: TimeZone) -> String {
    let timeResult = Double(dt)
    let date = Date(timeIntervalSince1970: timeResult)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = localTimeZone
    dateFormatter.locale = Locale(identifier: locale)
    dateFormatter.dateFormat = dateFormat
//    print(#function, date, localTimeZone)
    return dateFormatter.string(from: date)
}

//MARK: - Date/Time custom style formatte

func customDateStyle() -> Date.FormatStyle {
     Date.FormatStyle()
        .locale(Locale(identifier: locale))
        .weekday(iPadDevice ? .wide : .abbreviated) 
        .day(.twoDigits)
        .month(.wide) // vs .abbreviated
        .year(.defaultDigits)
        .hour(.defaultDigits(amPM: locale == "ru-Ru" || locale == "ru" ? .omitted : .abbreviated))
        .minute(.twoDigits)
}

