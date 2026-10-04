//
//  AudioEngine.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.12.2023.
//

import AVFoundation

class AudioEngine {
    var octaveNum: Int
    init(octaveNum: Int) {
        self.octaveNum = octaveNum
    }
    private let engine = AVAudioEngine()
    private let sampler = AVAudioUnitSampler()
    private let reverb = AVAudioUnitReverb()
    private let delay = AVAudioUnitDelay()
        
    func stop() {
        engine.stop()
    }
    
    func reset() {
        engine.reset()
    }

    func start() {
        engine.attach(sampler)
        engine.attach(reverb)
        engine.attach(delay)

        engine.connect(sampler, to: delay, format: nil)
        engine.connect(delay, to: reverb, format: nil)
        engine.connect(reverb, to: engine.mainMixerNode, format: nil)

        // Reverb
        reverb.loadFactoryPreset(.largeHall)
        reverb.wetDryMix = 30.0

        // Delay
        delay.wetDryMix = 15.0
        delay.delayTime = 0.00 ///Default = 0.50
        delay.feedback = 75.0
        delay.lowPassCutoff = 16000.0

        //        setSessionCategory(onlyPlay ? .playback : .playAndRecord)
        setSessionCategory(iPadDevice ? .playAndRecord : .playback)

        if engine.isRunning {
            print(#function, "Audio engine already running")
            return
        }

        do {
            try engine.start()
            print(#function, "Audio engine started, octave number = \(octaveNum)")
        } catch {
            print("Error: couldn't start audio engine")
            return
        }
    }
}

extension AudioEngine: PianoKeyboardDelegate {
    func pianoKeyDown(_ keyNumber: Int) {
        sampler.startNote(UInt8(keyNumber + (octaveNum)*12), withVelocity: 127, onChannel: 0)
    }

    func pianoKeyUp(_ keyNumber: Int) {
        sampler.stopNote(UInt8(keyNumber + (octaveNum)*12), onChannel: 0)
    }
}
