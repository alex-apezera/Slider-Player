//
//  AudioManager.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.04.2023.
//
// AudioPlayer Alternate


import Foundation
import AVKit

final class AudioManager: ObservableObject {
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            print("\n", #function, "=", isPlaying)
        }
    }
    @Published private(set) var isLooping: Bool = false
    
    var player: AVAudioPlayer?
    
    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: ".mp3") else { print(#function, "Resource not found: \(track)"); return }
        
        startPlayer(at: url, isPreview: isPreview)
    }
    
    func startPlayer(at url: URL, isPreview: Bool = true) {
        setSessionCategory(.playback)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print(#function, url.lastPathComponent)
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
            }
        } catch {
            print(#function, "Fail to initialize player", error)
        }
    }
    
    func playPause() {
        guard let player = player else {
            print(#function, "Instance of AVPlayer not found")
            return
        }
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func stop() {
        guard let player = player else {return}
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func toggleLoop() {
        guard let player = player else {return}
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
    }
}
