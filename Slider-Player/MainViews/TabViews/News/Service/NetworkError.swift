//
//  NetworkError.swift
//  NewsApp
//
//  Created by Алексей Езерский on 18.11.2024.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case invalidResponse = "Invalid response from server"
    case invalidData = "Invalid data received from server"
    
}
