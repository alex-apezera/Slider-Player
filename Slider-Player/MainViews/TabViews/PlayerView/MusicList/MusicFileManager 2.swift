//
//  Manager.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 14.05.2024.
//

import SwiftUI

//MARK: - Music file manager

@MainActor
final class MusicFileManager: ObservableObject {
    @Published var musicFiles: [URL] = []
    @Published var pieces: [MusicDataModel] = []
    
    static var shared = MusicFileManager()
    
//MARK: - Path to store [MusicDataModel]
    var musicDataURL = FileManager.musicFilesDir.appendingPathComponent("musicData.json", conformingTo: .url)
 
//MARK: - Create subdirectory musicFilesDir
    init() {
        do {
            try FileManager.default.createDirectory(at: FileManager.musicFilesDir, withIntermediateDirectories: true, attributes: nil) ///See Utility/Extensions
        } catch {
            print("Failed to create folder: \(FileManager.musicFilesDir)")
            print(#function, error.localizedDescription)
        }
    }
//MARK: - Remove MusicDataObject from subdir Music Files
    func removeMusicDataObject() {
        do {
            try FileManager.default.removeItem(at: musicDataURL)
            print(#function, "Successfully deleted \(musicDataURL.lastPathComponent)!")
        } catch {
            print(#function, "Error deleting \(musicDataURL.lastPathComponent): \(error)")
        }
    }
//MARK: - Store MusicDataObject to subdir Music Files
    func storeMusicDataObject(_ musicDataObject: [MusicDataModel]) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(musicDataObject)
            // Save jsonData to a file
            try jsonData.write(to: musicDataURL)
//            print(#function, musicDataURL)
        } catch {
            print(#function, "Error encoding data: \(error)")
        }
    }
//MARK: - Retrieve MusicDataObject from subdir Music Files
    func retrieveMusicDataObject() -> [MusicDataModel] {
        var musicDataModel = [MusicDataModel]()
        do {
            // Retrieve jsonData from the file using FileManager
            let jsonData = try Data(contentsOf: musicDataURL)
            let jsonDecoder = JSONDecoder()
            let readingData = try jsonDecoder.decode([MusicDataModel].self, from: jsonData)
            // Use the `readingData` array in your app
            musicDataModel = readingData
//            print(#function, musicDataURL)
        } catch {
            print(#function, "Error decoding data: \(error)")
        }
        musicFiles = musicDataModel.map{$0.file}
        return musicDataModel
    }
//MARK: - Get Album title image URL from Track
    func albumURL(from track: URL) -> URL {
        let imagePath = track.deletingPathExtension().lastPathComponent
        return FileManager.musicFilesDir.appendingPathComponent("\(imagePath).jpeg")
    }

//MARK: - Save music file
    func saveMusicFile(url: URL) {
        if url.startAccessingSecurityScopedResource() {
            do {
                let musicFile = try Data(contentsOf: url)
                let savePath = FileManager.musicFilesDir.appendingPathComponent(url.lastPathComponent)
                if savePath.isAudio {
                    try musicFile.write(to: savePath, options: .atomic)
                    musicFiles.append(savePath)
                    print(#function, "Success to save/append file: \(url.lastPathComponent)")
                }
            } catch {
                print("Failed to save the music file:")
                print(#function, error.localizedDescription)
            }
            url.stopAccessingSecurityScopedResource()
        } else {
            print(#function, "Permission failed!")
        }
    }
//MARK: - Retrieve all music files from subdirectory
    func getMusicFiles() {
        do {
            let musicFiles = try FileManager.default.contentsOfDirectory(atPath: FileManager.musicFilesDir.path)
            self.musicFiles.removeAll()
            for musicFile in musicFiles {
                let musicFileURL = URL(filePath: musicFile)
                if musicFileURL.isAudio {
                    self.musicFiles.append(musicFileURL)
//                    print(#function, "Successfully append file -> \(musicFileURL.lastPathComponent)")
                }
            }
        } catch {
            print("Failed to retrieve items:")
            print(#function, error.localizedDescription)
        }
    }
//MARK: - Remove a music file and album image file from subdirectory
    func removeMusicFile(url: URL) {
        if let index = musicFiles.firstIndex(of: url) {
            musicFiles.remove(at: index)
            pieces.remove(at: index)
            let musicFile = url.lastPathComponent
            do {
                let item = FileManager.musicFilesDir.appendingPathComponent(musicFile)
                try FileManager.default.removeItem(at: item) //.m4a
                try FileManager.default.removeItem(at: albumURL(from: item)) //.jpeg
                print(#function, "Successfully deleted both music and album image files -> \(musicFile)")
            } catch {
                print(#function, "Error: file \(musicFile) not exist ", error.localizedDescription)
            }
        }
    }
//MARK: - Copy a music file from subdirectory to directory with audiofiles
    func copyMusicFileToAudios(from musicURL: URL) {
        do {
            guard let documentDirectory = documentDirectory else { return }
            let audioURL = documentDirectory.appendingPathComponent(musicURL.lastPathComponent)
            let musicFile = try Data(contentsOf: musicURL)
            try musicFile.write(to: audioURL)
        } catch {
            print(#function, "Copy \(musicURL.lastPathComponent) failed! ", error.localizedDescription)
        }
    }
    
}// end Manager
