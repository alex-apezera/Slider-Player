//
//  MusicRowView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.06.2024.
//

import SwiftUI
extension MusicListView {
    //MARK: - Show music list row
    func musicRowView(_ musicData: MusicDataModel) -> some View {
        let track = FileManager.musicFilesDir.appendingPathComponent(musicData.file.lastPathComponent)
        let song = musicData.song.isEmpty ? track.lastPathComponent : musicData.song

        return HStack {
            Button {
                prepareMidiPlayer(for: track)
                albumImageURL = manager.albumURL(from: track)
            } label: {
                ArtworkView(size: 70, url: manager.albumURL(from: track))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(musicData.composer).bold()
                Text(song)
            }
        }
        .font(.system(size: 14))
        .lineLimit(5)
//        .frame(height: 80)
    }
}
