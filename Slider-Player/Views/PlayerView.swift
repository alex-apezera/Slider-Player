//
//  PlayerView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.02.2023.
//
/*
 Пример Аудиоплеера с Пикером и Слайдером;
 Передача данных
 */

import SwiftUI

struct PlayerView: View {
    @State private var progress: Float = 0
    @State private var isPlaying: Bool = false
    @State private var isEditing: Bool = false
    @State private var isSharePresented = false
    @State private var showPlayer = false
    @State private var expandPlayer: Bool = false
    @State private var offSetX = 0
    @State private var pieceIndex: Int = 0
    
    @ObservedObject var piece = Piece()
    @ObservedObject var playerModel = PlayerViewModel()
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.offSetX = 0
        })
    }
    
    var body: some View {
            NavigationStack {
                VStack {
                    
                    //MARK: - Music Piece Info
                    
                    HStack {
                        Image(systemName: "music.note")
                            .imageScale(.large)
                            .foregroundColor(.yellow)
                            .bold()
                        Spacer()
                        Text("\(piece.pieceTitle[pieceIndex])")
                            .font(.system(size: 24, weight: .light, design: .default))
                        Spacer()
                        Button {
                            showPlayer = true
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.system(size: 24))
                                .opacity(0.6)
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: $showPlayer) {
                            PieceInfo()
                                .environmentObject(piece)
                                .environmentObject(AudioManager())
                        }
                    }
                    .padding()
                    
                    //MARK: - Music Album Image
                    Button {
                        showPlayer = true
                    } label: {
                        Image(piece.pieceImage[pieceIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 5)
                            .cornerRadius(10)
//                            .frame(width: 400, height: 400)
                            .animation(Animation.easeInOut(duration: 1.5), value: offSetX)
                    }.buttonStyle(.borderless)
                    .sheet(isPresented: $showPlayer) {
                        PieceInfo()
                            .environmentObject(piece)
                            .environmentObject(AudioManager())
                    }

                    //MARK: - Music View Picker
                    Picker(selection: Binding(
                        get: {pieceIndex},
                        set: { newValue in
                            pieceIndex = newValue
                            piece.pieceIndex = pieceIndex
                            offSetX = -500
                            moveBack()
                            print(piece.pieceIndex)
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
                        .frame(width: UIScreen.main.bounds.width - 10)
                        .padding()

                    Spacer()
                    
                    //MARK: - Button PLAY/PAUSE
                    
                    HStack{
                        Button(isPlaying ? "STOP" : "PLAY") {
                            withAnimation(.spring()) {
                                expandPlayer = true
                                isPlaying.toggle()
                                if isPlaying && progress == 0 {
                                    playerModel.play(name: piece.pieceTrack[pieceIndex])
                                } else if isPlaying && progress > 0 {
                                    playerModel.setTime(value: progress)
                                } else { playerModel.pause()
                                }
                            }
                        }
                        Spacer()
                        
                        //MARK: - Playing time
                        
                        Text("Current time: \(Int(progress)) s")
                            .foregroundColor(isEditing ? .red : .blue)
                            .font(.system(size: 16))
                        Spacer()
                        
                        //MARK: - ActivityView Button
                        
                        Button("SHARE") {
                            self.isSharePresented = true
                            playerModel.play(name: "ding")
                        }
                        .sheet(isPresented: $isSharePresented) {
                            ShareInfo()
                            // Альтернативный способ использования функции share
                            //                        ActivityView(activityItems: ["Input the message text"])
                        }
                    }
                    .buttonStyle(GradientButtonStyle())
                    .frame(width: UIScreen.main.bounds.width - 10)
                    
                    //MARK: - Slider
                    Slider(value: Binding(
                        get: {Double(progress)},
                        set: { newValue in
                            print(newValue)
                            progress = Float(newValue)
                            playerModel.setTime(value: progress)
                            isPlaying = true
                        }),
                           in: 0...playerModel.maxDuration
                    ) { Text("Progress: \(progress)")
                    } minimumValueLabel: {
                        Text("0").font(.system(size: 12))
                    } maximumValueLabel: {
                        Text(String(Int(playerModel.maxDuration))).font(.system(size: 12))
                    } onEditingChanged: { editing in
                        isEditing = editing
                    }
                    .frame(width: UIScreen.main.bounds.width - 10)
                }
                .onReceive(timer) { _ in
                    guard let player = playerModel.player, !isEditing else { return }
                    progress = Float(player.currentTime)
                }
                .padding()
            }
            .navigationTitle("Player")
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(AudioManager())
    }
}
