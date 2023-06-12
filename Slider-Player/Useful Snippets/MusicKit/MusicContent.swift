//
//  MusicContent.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 31.05.2025.
//

//import SwiftUI
//import MusicKit
/*
struct ContentView: View {
    @State private var searchText = ""
    @State private var searchResults: [Song] = []

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearchButtonChanged: searchMusic)
                List(searchResults, id: \.id) { song in
                    SongRow(song: song)
                }
            }
            .navigationTitle("SwiftMusicKit")
        }
    }
    
    private func searchMusic() {
        Task {
            do {
                searchResults = try await MusicKit.search(for: searchText)
            } catch {
                print("Error searching for music: \(error.localizedDescription)")
            }
        }
    }
    
}

class MusicPlayer: ObservableObject {
    private let musicPlayer = SystemMusicPlayer.shared

    func play(song: Song) async {
        do {
            try musicPlayer.setQueue(with: [song.id])
            try await musicPlayer.play()
        } catch {
            print("Error playing the song: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
*/
