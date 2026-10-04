//
//  SpeechItem.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.12.2024.
//

import Foundation

struct SpeechItem : Identifiable, Codable {
    var id = UUID()
    var message = ""
    var date = ""
}

extension SpeechItem: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
