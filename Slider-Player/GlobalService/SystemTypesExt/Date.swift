//
//  Extension+Date.swift
//  NewsApp
//
//  Created by Алексей Езерский on 18.11.2024.
//

import Foundation

extension Date {
    var convertingToString: String {
        formatted(.dateTime.hour().minute().day().month().year())
    }
}
