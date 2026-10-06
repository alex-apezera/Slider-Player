//
//  AudioView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.05.2024.
//

import SwiftUI
import Combine

struct AudioView: View {
    @Binding var playing: Bool
    var albumImageURL: URL
    var albumTitle: String
    var composerName: String
    var songName: String
    
    @EnvironmentObject var audioManager: AudioManager
    @State var value: Double = 0.0
    @State var isEditing: Bool = false
    
//MARK: - Detect device type for AudioView size
    var size: CGFloat {
        if iPadDevice {
            return 500
        } else {
            return 300
        }
    }
//MARK: - Set Timer for Slider
    let timer = Timer
        .publish(every: 0.01, on: .main, in: .common)
        .autoconnect()
    
//MARK: - Midi Player view
    var body: some View {
        if let player = audioManager.player {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 5) {
                    //MARK: - Information about song
                    VStack {
                        ArtworkView(size: size*0.8, url: albumImageURL)
                            .padding(30)
                        Text(albumTitle)
                            .padding(5)
                        Text("Playing:").font(.title3)
                        Text(composerName)
                        Text(songName).font(.subheadline)
                    }
                    HStack {
                        Spacer()
                        //MARK: - Backward
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                        }
                        Spacer()
                        //MARK: - Play/Pause
                        PlaybackControlButton(systemName: audioManager.isPlaying && player.currentTime != 0 ? "pause.circle.fill" : "play.circle.fill") {
                            audioManager.playPause()
                        }
                        Spacer()
                        //MARK: - Forward
                        PlaybackControlButton(systemName: "goforward.10") {
                            player.currentTime += 10
                        }
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    //MARK: - Slider and Progress timer
                    Slider(value: $value, in: 0...player.duration) { editing in
                        isEditing = editing
                        if !editing {
                            player.currentTime = value
                        }
                    }
                    .padding()
                    .frame(height: 10)
                    .accentColor(.mint)
                    HStack {
                        Text(DateComponentsFormatter.pozitional.string(from: player.currentTime) ?? "0:00").foregroundStyle(.mint)
                        Spacer()
                        Text(DateComponentsFormatter.pozitional.string(from: player.duration - player.currentTime) ?? "0:00").foregroundStyle(.gray)
                    }
                    .font(.caption).padding()
                }
                //MARK: - Manager block
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.4))
                .background(.ultraThinMaterial)
                .shadow(radius: 10)
                .frame(maxWidth: size)
                .cornerRadius(15)
                .onDisappear {audioManager.stop()}
                .onReceive(timer) { _ in
                    guard !isEditing else { return }
                    value = player.currentTime
                }
                .overlay(alignment: .topLeading) {
                    Button {
                        withAnimation {playing = false}
                    } label: {
                        Image(systemName: "xmark.circle").font(.title).foregroundStyle(.pink).opacity(0.5).padding(5)
                    }
                }
            }
        }
    }
}
