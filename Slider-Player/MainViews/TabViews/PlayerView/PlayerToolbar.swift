//
//  PlayerToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.06.2024.
//

import SwiftUI
extension PlayerView {
    @ToolbarContentBuilder var playerToolbar: some ToolbarContent {
        
        ToolbarItemGroup(placement: .automatic) {
            HStack(spacing: 35) {
                
                //MARK: - Music list + Player
                if iPadDevice {
                    NavigationLink {
                        MusicListView().environmentObject(AudioManager())
                    } label: {
                        Image(systemName: "music.note.list")
                    }
                    .disabled(isPlaying)
                } else {
                    Button {
                        withAnimation {showPhoneMusicList = true}
                    } label: {
                        Image(systemName: "music.note.list")
                    }
                    .disabled(isPlaying)
                    .sheet(isPresented: $showPhoneMusicList) {
                        NavigationView {
                            MusicListView().environmentObject(AudioManager())
                        }
                    }
                }
                
                //MARK: - Audio list + recorder
                NavigationLink {
                    AudioRecorder(audios: $audios)
                        .environmentObject(AudioManager())
                } label: {
                    Image(systemName: "record.circle")
                }
                .disabled(isPlaying)
                
                //MARK: - Music Keyboard + recorder
                NavigationLink(destination: PianoKeyboard().environmentObject(AudioManager())) {
                    Image(systemName: "pianokeys")
                }
                //MARK: - Speech recognizer
                NavigationLink(destination: SpeechView()) {
                    Image(systemName: "person.wave.2")
                }
                
                //MARK: - iTunes list
                NavigationLink(destination: SearchView()) {
                        Image(systemName: "music.pages.fill")
                }
                .foregroundStyle(.pink).opacity(0.8)
                .disabled(isPlaying)
                
            }
            .clipShape(.capsule)
        }
    }
}
