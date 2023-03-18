//
//  RelativeProgressView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.03.2023.
//
/*
 Включается Плеер.
 Показывает текущее время, краткое название пьесы и кнопку выхода;
 загужает и показывает фонове изображение, Слайдер с полосой прогресса;
 кнопки управления Плеером
*/
import SwiftUI

struct ShowPlayer: View {
    @EnvironmentObject var piece: Piece
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var isPreview: Bool = false
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    //        .sink() {
    //            print ("timer fired: \($0)")
    //    }
    
    var body: some View {
        
        ZStack {
            Color.black
                .opacity(1.0)
                .edgesIgnoringSafeArea(.all)
            
            //MARK: Background Image
                        
            SkyView()  // Используется в качестве фона проигрывателя
            
            VStack(spacing: 5) {
                //MARK: Timeline
                TimelineView(.everyMinute) { context in
                    Text(context.date.formatted())
                        .foregroundColor(.teal)
                    // Show current time.
                }

                //MARK: Dismiss button
                HStack {
                    
                    Button {
                        withAnimation {
                            audioManager.stop()
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                //MARK: Title a piece
                Text(piece.pieceTitle[piece.pieceIndex])
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
                
                //MARK: Playback
                
                if let player = audioManager.player {
                    VStack (spacing: 5) {
                        //MARK: Timeline
                        
                        Slider(value: $value, in: 0...player.duration) { editing in
                            print("editing", editing)
                            isEditing = editing
                            if !editing {
                                player.currentTime = value
                            }
                        }
                            .padding()
                            .frame(height: 20)
                            .accentColor(.red)
                        
                        //MARK: Playing Time
                        HStack {
                            Text(DateComponentsFormatter.pozitional.string(from: player.currentTime) ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.pozitional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }.font(.caption).foregroundColor(.white).padding()
                    }
                    
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
                }
            }
            .buttonStyle(.borderless)
            .padding(10)
        }
        .onAppear {
            audioManager.startPlayer(track: piece.pieceTrack[piece.pieceIndex], isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return }
            value = player.currentTime
        }
    }
}

struct ShowPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ShowPlayer()
            .environmentObject(Piece())
            .environmentObject(AudioManager())
    }
}

