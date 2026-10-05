//
//  AudioActions.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.08.2024.
//

import SwiftUI
import AVKit

//MARK: - Set session category

func setSessionCategory(_ category: AVAudioSession.Category) {
    DispatchQueue.global(qos: .userInitiated).async {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(category, mode: .default)
            try session.setActive(true)
        } catch {
            print(#function, error.localizedDescription)
        }
    }
}


//MARK: - Play Audio

func playAudio(_ track: URL, player:  inout AVAudioPlayer?) {
    do {
        try player = AVAudioPlayer(contentsOf: track)
        player?.play()
    } catch {
        print(#function, error.localizedDescription)
    }
}

//MARK: - Record and Store Audio

func recordAndStoreAudio(record: inout Bool, recorder: inout AVAudioRecorder!, audios: inout [URL]) {
    
    // updating session for recording with playback
    setSessionCategory(.playAndRecord)
    
    // updating data for every rcd...
    getAudios(&audios)
    
    if record {
        // Already Started Recording means stopping and saving...
        recorder.stop()
        record.toggle()
        return
    }
    
    // same file name...
    // so were updating based on audio count...
    let settings = [
        AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey : 12000,
        AVNumberOfChannelsKey : 1,
        AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
    ]
    do {
        if let fileName = documentDirectory?.appendingPathComponent("Audio-\(audios.count + 1).m4a") {
            recorder = try AVAudioRecorder(url: fileName, settings: settings) }
        recorder.record()
        record.toggle()
    } catch {
        print(#function, error.localizedDescription)
    }
}


