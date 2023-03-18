//
//  MusicWorkInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.03.2023.
//
/*
 Тестирование перехода с передачей данных
  Пример альтернативного Аудиоплеера с передачей данных из двух источников
*/

import SwiftUI

struct PieceInfo: View {
    @State private var showPlayer = false
    @EnvironmentObject var piece: Piece
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                //MARK: - Show Piece
                
                Spacer()
                Image(piece.pieceImage[piece.pieceIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .cornerRadius(10)
                
                Text(piece.pieceTitle[piece.pieceIndex])
                    .foregroundColor(.accentColor)
                    .background(.clear)
                    .font(.body)
                
                //MARK: Details of the Screen
                
                ZStack {
                    Color(red: 24/255, green: 23/255, blue: 22/255)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Album: \(piece.pieceAlbumTitle[piece.pieceIndex])")
                            Spacer()
                            Text("Piece: " + piece.pieceDescription[piece.pieceIndex])
                            Spacer()
                            HStack {
                                Text("Duration: " + piece.pieceDuration[piece.pieceIndex].formatted() + "s")
                            }
                        }
                        .font(.subheadline)
                        .opacity(0.7)
                        
                        //MARK: Show Player button
                        Button {
                            showPlayer.toggle()
                        } label: {
                            Label("Start Player", systemImage: "play.fill")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .padding(.top, 5)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(20)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(20)
                }
//                .frame(width: UIScreen.main.bounds.height * 0.46)
                .font(.system(size: 16))
                .padding()
                .fullScreenCover(isPresented: $showPlayer) {
                    ShowPlayer()
                }
            }
            .buttonStyle(.borderless)
        }
    }
}
struct PieceInfo_Previews: PreviewProvider {
    static var previews: some View {
        PieceInfo()
            .environmentObject(Piece())
            .environmentObject(AudioManager())
    }
}
