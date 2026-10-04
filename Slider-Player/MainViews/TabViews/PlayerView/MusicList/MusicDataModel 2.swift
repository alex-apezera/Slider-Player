//
//  MusicDataModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.06.2024.
//

import Foundation

struct MusicDataModel: Codable, Identifiable {
    var id = UUID()

    var file: URL
    var album: String
    var composer: String
    var song: String
}
extension MusicDataModel: Equatable {
    static func == (lhs: MusicDataModel, rhs: MusicDataModel) -> Bool {
        lhs.id == rhs.id
    }
}
