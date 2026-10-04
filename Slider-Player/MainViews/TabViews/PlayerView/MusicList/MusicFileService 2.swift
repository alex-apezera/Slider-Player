//
//  MusicEdit.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.06.2024.
//

import SwiftUI

extension MusicListView {
    //MARK: - Calculate offsets to action
    func offsetsToAction(for codes: [UUID]) -> IndexSet {
        let files = manager.pieces
        var offsets: IndexSet = []
        for (index, element) in files.enumerated() where  codes.contains(element.id) {
                offsets.insert(index)
        }
        return offsets
    }
    //MARK: - Copy files
    func copyMusicFiles(for codes: [UUID]) {
        let files = manager.pieces
        copyingTrack = ""
        for index in offsetsToAction(for: codes) {
            let track = FileManager.musicFilesDir.appendingPathComponent(files[index].file.lastPathComponent)
            copyingTrack += track.lastPathComponent + ",  "
            manager.copyMusicFileToAudios(from: track)
        }
    }
    //MARK: - Track for export music file
    func exportTrack(for codes: [UUID]) -> URL {
        var track = URL(fileURLWithPath: "")
        let files = manager.pieces
        for index in offsetsToAction(for: codes) {
            track = FileManager.musicFilesDir.appendingPathComponent(files[index].file.lastPathComponent)
        }
        return track
    }
    //MARK: - Delete functions
    func deleteMusicFiles(at offsets: IndexSet) {
        var files = manager.pieces
        for index in offsets {
            let fileURL = files[index].file
            manager.removeMusicFile(url: fileURL)
        }
        files.remove(atOffsets: offsets)
    }
    func deleteMusicFiles(for codes: [UUID]) {
        deleteMusicFiles(at: offsetsToAction(for: codes))
        selection.removeAll()
    }
    //MARK: - Move files
    func moveMusicFiles(source: IndexSet, destination: Int) {
        var files = manager.pieces
        files.move(fromOffsets: source, toOffset: destination)
        manager.pieces = files

        var musicFiles = manager.musicFiles
        musicFiles.move(fromOffsets: source, toOffset: destination)
        manager.musicFiles = musicFiles
    }
}
