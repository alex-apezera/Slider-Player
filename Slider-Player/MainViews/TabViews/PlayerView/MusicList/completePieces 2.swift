//
//  CompletePieces.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.06.2024.

//MARK: - retrieve metadata from a track

import Foundation
extension MusicListView {
    
    func completePieces() {
        isLoading = true
        Task {
            manager.pieces.removeAll()
            for file in manager.musicFiles {
                let track = FileManager.musicFilesDir.appendingPathComponent(file.lastPathComponent)
                do {
                    try await GetAudioAssets(url: track, albumTitle: $albumTitle, composerName: $composerName, songName: $songName).takeData()
                    if songName.isEmpty {
                        songName = file.deletingPathExtension().lastPathComponent
                    }
                    let piece = MusicDataModel(file: file, album: albumTitle, composer: composerName, song: songName)
                    
                    manager.pieces.append(piece)
                    
                } catch {
                    print(#function, "Failed to retrieve music data from \(track.lastPathComponent): ", error.localizedDescription)
                }
            }
            isLoading = false
        }
    }
}
