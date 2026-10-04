//
//  GalleryPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//

/*
//MARK: - Pick, load, get data from photoLibraty

import PhotosUI
import SwiftUI

struct GalleryPicker: View {
    @Binding var galleryFiles: [URL]
    let movieMode: Bool
    @Binding var refreshView: Bool /// be shure to refresh GalleryList
    
    enum LoadState {
        case unknown, loading, loaded(Movie), loadedPhoto(Photo), failed
    }
    @State private var selectedItem: PhotosPickerItem?
    @State private var loadState = LoadState.unknown
    
    @EnvironmentObject var galleryObject: GalleryObject
    
    @State var date = Date()
    @State var placeName = ""
    @State var address = ""
    @State var latitude: CLLocationDegrees = 0
    @State var longitude: CLLocationDegrees = 0
    @State var fileURL: URL?
    
    @AppStorage("lastUpdatedMovies") var lastUpdatedMovies = Date.distantFuture.timeIntervalSince1970
    @AppStorage("isLoadingMovie") var isLoading: Bool = false
    @AppStorage("galleryFilesCount") var galleryFilesCount: Int = 0
    @AppStorage("selectMovie") var selectMovie: Bool = true
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")

    var body: some View {
        VStack {
            if selectMovie {
                PhotosPicker(String.selectMovie, selection: $selectedItem, matching: .videos, photoLibrary: .shared())
            } else {
                PhotosPicker(String.selectImage, selection: $selectedItem, matching: .images, photoLibrary: .shared())
            }
            switch loadState {
            case .unknown:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let movie):
                MoviePlay(url: movie.url)
                Text.dataDescription(placeName, address, date)
            case .loadedPhoto(let photo):
                DetailImageView(url: photo.url)
                Text.dataDescription(placeName, address, date)
            case .failed:
                Text(verbatim: .importFailed)
            }
        }
        .onAppear { selectMovie = movieMode }
        .navigationModifier(movieMode ? String.movies : String.images)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: selectedItem) { newValue in
            isLoading = true; date = Date(); placeName = ""; address = ""
            copyFile = URL.galleryDirectory.appending(path: "\(randomString(length: idLength))")
            Task {
                do {
                    loadState = .loading
                    if let movie = try await newValue?.loadTransferable(type: Movie.self) {
                        loadState = .loaded(movie)
                        fileURL = movie.url
                    }
                    if let photo = try await newValue?.loadTransferable(type: Photo.self) {
                        loadState = .loadedPhoto(photo)
                        fileURL = photo.url
                    }
                    try await getAssets()
                } catch {
                    loadState = .failed
                    print("\n", "Object loading error: \(error)")
                }
                isLoading = false
            }
        }
    }
    
    func getAssets() async throws {
        getGalleryFiles(&galleryFiles)
        galleryFilesCount = galleryFiles.count
        lastUpdatedMovies = Date().timeIntervalSince1970
        guard let selectedItem else { return }
        guard let fileURL else { return }
        let id = fileURL.deletingPathExtension().lastPathComponent
        let galleryAsset = GalleryAsset(refreshView: $refreshView, date: $date, placeName: $placeName, address: $address, latitude: $latitude, longitude: $longitude)
        try await galleryAsset.takeData(from: selectedItem, at: id)
    }
}
*/
