//
//  PlayerModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.02.2023.
//
// Simple player model

import Foundation
import AVKit

class PlayerModel: ObservableObject {
    @Published var maxDuration = 0.0
    @Published var currentTimeOfPlay = 0.0
    var player: AVAudioPlayer?
    
    public func play(name: String) {
        playSong(name: name)
        player?.play()
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else {return}
        player?.currentTime = time
        currentTimeOfPlay = time 
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print(#function, "Resource not found: \(name)")
            return
        }
        setSessionCategory(.playback)
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}
