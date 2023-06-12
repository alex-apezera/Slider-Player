//
//  AudioFunc.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.06.2024.
//

import SwiftUI
import AVKit
extension AudioRecorder {
    
    //MARK: - Intializing audio session

    func initSession() {
        setSessionCategory(.playback)
        AVAudioSession.sharedInstance().requestRecordPermission { status in
            if !status{
                // error msg...
                alert.toggle()
            }
            else{
                // if permission granted means fetching all data...
                getAudios(&audios)
                audiosCount = audios.count
            }
        }
    }
//MARK: - Remove an audio file
    func removeAudio(at item: URL) {
        if let index = audios.firstIndex(of: item) {
            do {
                try FileManager.default.removeItem(at: item)
                audios.remove(at: index)
                audiosCount = audios.count
                print(#function, "Successfully deleted file -> \(item.lastPathComponent)")
            } catch {
                print(#function, "Error: file \(item.lastPathComponent) not exist")
            }
        }
    }
//MARK: - Remove all audio files
    func removeAllAudios() {
        guard let documentDirectory = documentDirectory else {return}
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            for url in urls{
                if url.isAudio {
                    try FileManager.default.removeItem(at: url)
                    print(#function, "Successfully deleted file -> \(url.lastPathComponent)")
                }
            }
            audios.removeAll()
            audiosCount = 0
        } catch {
            print(#function, "Error deleting file: \(error)")
        }
    }
}
