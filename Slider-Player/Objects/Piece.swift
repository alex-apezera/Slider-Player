//
//  UserObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.02.2023.
//

import Foundation

class Piece: ObservableObject, Identifiable {
    @Published var id = UUID()
    @Published var pieceIndex = 0
    @Published var pieceNumber: [Int] = [0, 1, 2, 3]
    @Published var pieceTrack = ["Aria", "Adagio", "Lohengrin", "Nocturne"]
    @Published var pieceImage = ["50Most", "Mozart", "Wagner", "50Most"]
    @Published var pieceTitle = ["Aria, J.S.Bach", "Adagio, W.A.Mozart", "Lohengrin, R.Wagner", "Nocturne, F.Chopin"]
    @Published var pieceDescription = ["Aria mit 30 Veränderungen, BWV 988 Goldberg Variations, J.S.Bach", "Adagio in E Major for Violin and Orchestra, K. 261, W.A.Mozart", "Lohengrin, WWV 75: Prelude to Act III, R.Wagner", "Nocturne No. 2 in E-Flat Major, Op. 9 No. 2, F.Chopin"]
    @Published var pieceAlbumTitle = ["The 50 Most Essential Classical Music Pieces Ever", "Mozart: Essential Works", "Wagner: Opera Favorites", "The 50 Most Essential Classical Music Pieces Ever"]
    @Published var pieceDuration: [TimeInterval] = [233, 442, 177, 242]
    @Published var imageFromWeb = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
}
