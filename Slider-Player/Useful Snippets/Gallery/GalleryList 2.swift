//
//  GalleryList.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 12.02.2025.
//
/*
import SwiftUI
import AVFoundation

struct GalleryList: View {
    @State var galleryFiles: [URL] = []
    @ObservedObject var galleryObject: GalleryObject = GalleryObject()
    
    @AppStorage("lastUpdatedMovies") var lastUpdatedMovies = Date.distantFuture.timeIntervalSince1970
    @AppStorage("isLoadingMovie") var isLoading: Bool = false
    @AppStorage("galleryFilesCount") var galleryFilesCount: Int = 0
    @AppStorage("selectMovie") var selectMovie: Bool = true

    @State var startFileView = false
    @State var deleteAllFiles: Bool = false
    @State private var videoUrl: URL?
    @State private var uiimage = UIImage(systemName: "video.square.fill")!
    
    @State var refreshView = false
    
    var body: some View {
        
        List(galleryFiles, id: \.self) { file in
            let id = file.deletingPathExtension().lastPathComponent
            let assets = retrieveGalleryObject()
            if let index = assets.firstIndex(where: {$0.id == id}) {
                let asset = assets[index]
                
                NavigationLink {
                    if startFileView {
                        VStack {
                            DetailFileView(url: file)
                            Text.dataDescription(asset.placeName, asset.address, asset.date)
                        }
                        .navigationModifier(file.isImage ? String.photo : String.movie  )
                    }
                } label: {
                    HStack {
                        let size: CGFloat = 80
                        SelectedFileView(size: size, url: file)
                        Text.fileDescription(asset.date, asset.placeName)
                    }
                    .padding(.vertical, 3)
                    .swipeActions(edge: .trailing) {deleteOrExport(file)}
                }
            }
        }
        //MARK: - Manage Block
        .disabled(isLoading)
        .onAppear {refresh()}///load galleryFiles from directory
        .refreshable { refresh() }
        .toolbar { galleryToolbar() }
        .navigationModifier(String.gallery)
        .background(.thinMaterial)
        .id(refreshView)
    }
}
*/
