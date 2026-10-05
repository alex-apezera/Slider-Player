//
//  PlayerView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.02.2023.
//
// Audioplayer example
//
import SwiftUI
import Combine

struct PlayerView: View {
    @State var progress: Float = 0
    @State var isPlaying: Bool = false
    @State private var isEditing: Bool = false
    @State private var showPiece: Bool = false
    @State private var maxDuration: Double = 0
    @State var showPhoneMusicList = false
    @State private var offSetX = 0
    @AppStorage("pieceIndex") var pieceIndex: Int = 0
    @State var audios: [URL] = []
    
    @ObservedObject private var piece = Piece()
    @ObservedObject var playerModel = PlayerModel()
    @ObservedObject var manager = MusicFileManager()

    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.offSetX = 0
        })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
//MARK: - Show Piece info
                Button {
                    showPiece = true
                } label: {
                    Image(piece.pieceImage[pieceIndex])
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 5)
                        .cornerRadius(20)
                }
                .buttonStyle(Increasing())
                
//MARK: - Music View Picker
                Picker(selection: Binding(
                    get: {pieceIndex},
                    set: { newValue in
                        pieceIndex = newValue
                        piece.pieceIndex = newValue
                        offSetX = -500
                        moveBack()
                        isPlaying = false
                        progress = 0
                        playerModel.currentTimeOfPlay = Double(progress)
                        playerModel.play(name: piece.pieceTrack[pieceIndex])
                        playerModel.pause()
                    }), label: Text("")) {
                        ForEach(0..<piece.pieceTrack.count,  id: \.self) {
                            Text(self.piece.pieceTrack[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                
//MARK: - Playing time
                Text("\(.piece): \(piece.pieceTitle[pieceIndex]). \(.progress): \(Int(progress)) \(.sec)")
                    .foregroundColor(isEditing ? .red : .blue)
                    .font(.system(size: 12, weight: .light, design: .default))
                    .onAppear { if progress < 0 { progress = 0 }}
                
//MARK: - Slider
                Slider(value: Binding(
                    get: {Double(progress)},
                    set: { newValue in
                        progress = Float(newValue)
                        playerModel.setTime(value: progress)
                        isPlaying = true
                    }),
                       in: 0...maxDuration
                ) { Text("\(.progress): \(progress)")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text(String(Int(maxDuration - Double(progress))))
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .font(.system(size: 12))
            }
            .padding(10)
            .animation(Animation.easeInOut(duration: 1.5), value: offSetX)
            .onReceive(timer) { _ in
                guard let player = playerModel.player, !isEditing else { return }
                progress = Float(player.currentTime)
                maxDuration = playerModel.maxDuration
            }
            HStack {
//MARK: - Button PLAY/PAUSE
                Button {
                    isPlaying.toggle()
                    if isPlaying && progress == 0 {
                        playerModel.play(name: piece.pieceTrack[pieceIndex])
                    } else if isPlaying && progress > 0 {
                        playerModel.setTime(value: progress)
                    } else { playerModel.pause() }
                } label: {
                    Image(systemName: !isPlaying ? "play.circle.fill" : "pause.circle.fill")
                        .font(.system(size: 30))
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(Hovering(hoverMessage: isPlaying ? .pauseButton : .playButton))
            }
        }
//MARK: - Manage block
        .background(.secondary.opacity(0.3))
        .navigationModifier(String.player)
        .toolbar {playerToolbar}
        .sheet(isPresented: $showPiece) {
            PieceInfo()
                .environmentObject(piece)
                .environmentObject(AudioManager())
        }
    }
}
