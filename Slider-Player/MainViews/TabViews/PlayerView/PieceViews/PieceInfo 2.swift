//
//  PieceInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.03.2023.
//
// Alternate audio player

import SwiftUI

struct PieceInfo: View {
    @EnvironmentObject var piece: Piece
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("pieceIndex") var pieceIndex: Int = 0
    @State private var startPlayer = false
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            VStack(alignment: .center, spacing: 5) {
                
                //MARK: - Show Piece album image
                Image(piece.pieceImage[pieceIndex])
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(15)
                    .frame(width: iPadDevice ? width/1.6 : width/2.1, height: iPadDevice ? height/1.6 : height/2.1)
                    .padding(10)
                Text("\(.selected): \(piece.pieceTitle[pieceIndex])")
                    .font(.title3).bold()
                    .padding(.top, 10)
                
                //MARK: - Piece details
                ZStack {
                    Color(red: 30/255, green: 30/255, blue: 30/255)
                    VStack(alignment: .center, spacing: 24) {
                        VStack(alignment: .center, spacing: 8) {
                            Text("\(.album): \(piece.pieceAlbumTitle[pieceIndex])")
                            Text("\(.piece): \(piece.pieceDescription[pieceIndex])")
                            Text("\(.duration): \(piece.pieceDuration[pieceIndex].formatted()) \(.sec)")
                        }
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .opacity(0.85)
                        
                        //MARK: - Start Player
                        Button {
                            startPlayer = true
                        } label: {
                            Text(String.player)
                                .font(.title3).underline(false, color: .accentColor)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background(.white)
                                .cornerRadius(25)
                        }
                    }
                    .padding(.bottom, 10)
                }
                .frame(height: iPadDevice ? height/4.3 : height/2.3)
                .cornerRadius(15)
            }
            //MARK: - Manage block
            .frame(width: width, height: height)
            .padding(10)
            .buttonStyle(.borderless)
            .onAppear { audioManager.startPlayer(track: piece.pieceTrack[pieceIndex], isPreview: true) }
            .sheet(isPresented: $startPlayer) {
                ShowPlayer()
                    .environmentObject(piece)
                    .environmentObject(audioManager)
            }
        }
        .padding(.trailing, 20)
    }
}

