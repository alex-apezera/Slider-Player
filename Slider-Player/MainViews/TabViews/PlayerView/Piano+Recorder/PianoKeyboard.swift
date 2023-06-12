//
//  PianoKeyboard.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.12.2023.
//

import SwiftUI
import AVKit

struct PianoKeyboard: View {
    @State var audios: [URL] = []
    @State var record = false
    @State var playing = false
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State private var showAudioList = true
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("isAudioFinished") var isAudioFinished = false
    
//MARK: - Set Timer for Slider
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        HStack {
            
//MARK: - Call Recorder + Audio List
            if showAudioList {
                Button {
                    setSessionCategory(.playback)
                    getAudios(&audios)
                    showAudioList = false
                } label: {
                    Image(systemName: "list.triangle")
                }
            }
            // Play Audio from List
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(audios, id: \.self) { track in
                        Button {
                            audioManager.startPlayer(at: track, isPreview: false)
                            playing = true
                        } label: {
                            Image(systemName: "play.fill")
                        }
                        Text(track.deletingPathExtension().lastPathComponent).font(.footnote)
                    }
                }
            }
        }
        .padding()
        
//MARK: - Pianokeyboard(s)
        ScrollView {
            ForEach(0..<UserSettings().pianoKeyboards, id: \.self) { number in
                KeyboardView(keyboardNum: number)
            }
        }
//MARK: - Manager block
        .onReceive(timer) { _ in
            isAudioFinished = audioManager.player?.currentTime == 0.0
        }
        .onDisappear {audioManager.stop()}
        .toolbar {pianoToolbar()}
        .navigationModifier(iPadDevice ? String.pianoTitle : String.piano)
        .alert(isPresented: $alert) {
            Alert(title: Text(String.error), message: Text(String.errorMessage), dismissButton: .cancel(Text(String.cancel)))
        }
    }
}
