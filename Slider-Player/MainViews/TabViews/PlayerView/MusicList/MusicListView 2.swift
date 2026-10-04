//
//  MusicListView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.05.2024.
//
//  Music list + Midi player + import files

import SwiftUI
import MediaPlayer

struct MusicListView: View {
    
//MARK: - Properties
    @State var isFileImporterShown = false
    @State var copyFile = false
    @ObservedObject var manager = MusicFileManager.shared
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("soundLevel") var soundLevel = 1.0
    @State var playing = false
    @State var copyingTrack = ""
    
    @State var albumImageURL = URL(fileURLWithPath: "")
    @State var albumTitle = ""
    @State var composerName = ""
    @State var songName = ""
    
    @AppStorage("lastUpdatedMusicFiles") var lastUpdatedMusicFiles = Date.distantFuture.timeIntervalSince1970
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection = Set<UUID>()
    
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return .musicList
        } else {
            return "\(selection.count) \(String.piece)"
        }
    }

//MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .center) {
                
//MARK: - Music list
                List(selection: $selection) {
                    ForEach(manager.pieces) { musicData in
                        musicRowView(musicData)
                    }
                    .onDelete(perform: deleteMusicFiles)
                    .onMove(perform: moveMusicFiles)
                }
                .environment(\.editMode, $editMode)
                
//MARK: - Midi Player View
                if playing {
                    AudioView(playing: $playing, albumImageURL: albumImageURL, albumTitle: albumTitle, composerName: composerName, songName: songName)
                }
            }///end of ZStack
//MARK: - Sound level
            HStack{
                Image(systemName: "speaker")
                Slider(value: $soundLevel, in: 0...1, step: 0.05, onEditingChanged: { data in
                    MPVolumeView.setVolume(Float(self.soundLevel))
                })
                Text(String(format: "%.2f", soundLevel)).font(.footnote)
            }
            .frame(width: 300, height: 20)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }///end of VStack

//MARK: - Manage block
        .navigationModifier(title)
        .toolbar { musicToolbar() } // Include file import
        .onAppear {
            manager.getMusicFiles()
            completePieces()
        }
        .onDisappear {audioManager.stop()}
        .alert(isPresented: $copyFile) {
            Alert(title: Text(String.copyFile), message: Text(copyingTrack), dismissButton: .cancel(Text(String.actionOK)))
        }
    }
}
