//
//  RecordSession.swift
//  Audio Recorder
//
//  Created by Kavsoft on 03/06/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//  Corrected by Ezerskiy Alexey on 11/01/2024

//  Audio List + Player + Recorder

import SwiftUI
import AVKit

struct AudioRecorder: View {
    @Binding var audios: [URL]
    @State var record = false
    @State var playing = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State var addFile = false
    @State var isRemoveAll = false
    @State var albumTitle = ""
    @State var composerName = ""
    @State var songName = ""
    @State var albumImageURL = URL(fileURLWithPath: "")
    @EnvironmentObject var audioManager: AudioManager
    @ObservedObject var manager = MusicFileManager.shared
    @AppStorage("audiosCount") var audiosCount: Int = 0

    var body: some View {
        ZStack(alignment: .center) {
            
//MARK: - Audio List
            List(audios, id: \.self) { track in
                HStack {
                    //MARK: - start player and retrieve metadata from a track
                    Button {
                        withAnimation {playing = true}
                        audioManager.startPlayer(at: track)
                        albumImageURL = manager.albumURL(from: track)
                        Task {
                            try await GetAudioAssets(url: track, albumTitle: $albumTitle, composerName: $composerName, songName: $songName).takeData()
                        }
                    } label: {
                        Image(systemName: "speaker.square.fill").font(.title)
                    }
                    
                    //MARK: - Show and edit an audio file name
                    if let documentDirectory {
                        EditFileName(track: track, directory: documentDirectory)
                    }
                    
                    Spacer()
                    //MARK: - remove a track
                    Button { withAnimation { 
                        removeAudio(at: track) }
                    } label: {
                        Image(systemName: "trash")
                    }
                    //MARK: - export a track
                    ShareLink(item: track, subject: Text(String.exportTrack)) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }///List
//MARK: - Midi Player View
            if playing {
                AudioView(playing: $playing, albumImageURL: albumImageURL, albumTitle: albumTitle, composerName: composerName, songName: songName.isEmpty ? albumImageURL.deletingPathExtension().lastPathComponent : songName)
            }
        }///ZStack
//MARK: - Recorder + Manage Block
        .toolbar {recorderToolbar()}
        .navigationModifier(String.audio + ": " + String(audiosCount))
        .onAppear {initSession()}
        .onDisappear {audioManager.stop()}
        .alert(isPresented: $alert) {
            Alert(title: Text(String.error), message: Text(String.errorMessage), dismissButton: .cancel(Text(String.cancel)))
        }
    }
}
