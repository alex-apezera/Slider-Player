//
//  PlayerToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.06.2024.
//

import SwiftUI
extension PlayerView {
    @ToolbarContentBuilder var playerToolbar: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
//MARK: - iTunes list
            NavigationLink {
                SearchView()
            } label: {
                Image("music").resizable().scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaleEffect(0.65)
                    .position(x: 105, y: 20)
                    .opacity(isPlaying ? 0.5 : 1)
            }
            .disabled(isPlaying)
        }
        
        ToolbarItemGroup(placement: .bottomBar) {
            HStack(spacing: 60) {
                
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
            }
            .padding(8)
            .background(.thickMaterial)
            .clipShape(.capsule)
        }
    }
}
