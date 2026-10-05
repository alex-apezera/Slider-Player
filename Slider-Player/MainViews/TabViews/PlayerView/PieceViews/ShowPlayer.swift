//
//  RelativeProgressView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.03.2023.
//
// Player example with web picture

import SwiftUI
import Combine

struct ShowPlayer: View {

//MARK: - Properties
    @EnvironmentObject var piece: Piece
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @AppStorage("pieceIndex") var pieceIndex: Int = 0
    
    var isPreview: Bool = true
    
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()

    //MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack {
                    
                    //MARK: Background Image
                    BackGroundImage()  // Используется в качестве фона проигрывателя
                    
                    //MARK: Playback
                    if let player = audioManager.player {
                        
                        VStack(spacing: 5) {
                            
                            //MARK: Title a piece
                            Text(piece.pieceTitle[pieceIndex])
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            //MARK: Timeline
                            TimelineView(.everyMinute) { context in
                                Text(context.date.formatted())
                                    .foregroundColor(.teal)
                            }
                            Spacer()
                            
                            //MARK: Slider Timeline
                            Slider(value: $value, in: 0...(player.duration)) { editing in
                                isEditing = editing
                                if !editing {
                                    player.currentTime = value
                                }
                            }
                            .padding()
                            .frame(height: 10)
                            .accentColor(.red)
                            
                            //MARK: Playing Time
                            HStack {
                                Text(DateComponentsFormatter.pozitional.string(from: player.currentTime) ?? "0:00")
                                Spacer()
                                Text(DateComponentsFormatter.pozitional.string(from: (player.duration) - (player.currentTime)) ?? "0:00")
                            }
                            .font(.caption).foregroundColor(.white).padding()
                            
                            //MARK: Control Buttons
                            HStack {
                                //MARK: Repeat
                                let color: Color = audioManager.isLooping ? .teal : .white
                                PlaybackControlButton(systemName: "repeat", color: color) {
                                    audioManager.toggleLoop()
                                }
                                Spacer()
                                //MARK: Backward
                                PlaybackControlButton(systemName: "gobackward.10") {
                                    player.currentTime -= 10
                                }
                                Spacer()
                                //MARK: Play/Pause
                                PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill") {
                                    audioManager.playPause()
                                }.font(.system(size: 44))
                                Spacer()
                                //MARK: Forward
                                PlaybackControlButton(systemName: "goforward.10") {
                                    player.currentTime += 10
                                }
                                Spacer()
                                //MARK: Stop
                                PlaybackControlButton(systemName: "stop.fill") {
                                    player.currentTime = player.duration
                                    audioManager.stop()
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
                //MARK: - Manage block
                .frame(width: geo.size.width, height: geo.size.height)
                .scaledToFill()
                .buttonStyle(.borderless)
                .onAppear {
                    audioManager.startPlayer(track: piece.pieceTrack[pieceIndex], isPreview: isPreview)
                }
                .onDisappear(perform: audioManager.stop)
                .onReceive(timer) { _ in
                    guard let player = audioManager.player, !isEditing else { return }
                    value = player.currentTime
                }
            }
        }
    }
}

