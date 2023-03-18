//
//  MoviePicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//
/*
 Выбор, загрузка и проигрывание видео на реальном устройстве
 */

import AVKit
import PhotosUI
import SwiftUI

struct Movie: Transferable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
            print(copy)

            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
}

struct MoviePicker: View {
    enum LoadState {
        case unknown, loading, loaded(Movie), failed
    }

    @State private var selectedItem: PhotosPickerItem?
    @State private var loadState = LoadState.unknown

    var body: some View {
        VStack {
            PhotosPicker("Select movie", selection: $selectedItem, matching: .videos)

            switch loadState {
            case .unknown:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let movie):
                VideoPlayer(player: AVPlayer(url: movie.url))
                    .controlSize(.large)
//                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height / 1.3)
            case .failed:
                Text("Import failed")
            }
        }
        .onChange(of: selectedItem) { _ in
            Task {
                do {
                    loadState = .loading

                    if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
                        loadState = .loaded(movie)
                    } else {
                        loadState = .failed
                    }
                } catch {
                    loadState = .failed
                }
            }
        }
    }
}

struct MoviePicker_Previews: PreviewProvider {
    static var previews: some View {
        MoviePicker()
    }
}
