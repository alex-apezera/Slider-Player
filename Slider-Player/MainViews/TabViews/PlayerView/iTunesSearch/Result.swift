//
//  Result.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.08.2024.

//MARK: - Data model API for iTunes.apple

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl60: URL
    var artworkUrl100: URL
    var previewUrl: URL
}
