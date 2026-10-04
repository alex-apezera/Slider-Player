//
//  prepareMidiPlayer.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.10.2024.

//MARK: - Set data for MIDI player

import Foundation
extension MusicListView {
    
    func prepareMidiPlayer(for track: URL) {
        playing = true
        audioManager.startPlayer(at: track)
        Task {
            try await GetAudioAssets(url: track, albumTitle: $albumTitle, composerName: $composerName, songName: $songName).takeData()
            songName = songName.isEmpty ? track.lastPathComponent : songName
        }
    }
}
