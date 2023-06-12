//
//  GalleryToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 13.02.2025.
//
/*
import SwiftUI
extension GalleryList {
    @ToolbarContentBuilder func galleryToolbar() -> some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            //MARK: - Movie picker
            NavigationLink(destination: GalleryPicker(galleryFiles: $galleryFiles, movieMode: true, refreshView: $refreshView)
                .environmentObject(galleryObject)) {
                Label(String.movies, systemImage: "video")
            }
            //MARK: - Image picker
            NavigationLink(destination: GalleryPicker(galleryFiles: $galleryFiles, movieMode: false, refreshView: $refreshView)
                .environmentObject(galleryObject)) {
                Label(String.images, systemImage: "photo")
            }
        }

        //MARK: - Bottom State String
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton { refresh() }
            Spacer()
            ToolbarStatus(title: .files, isLoading: isLoading, lastUpdated: lastUpdatedMovies, count: galleryFiles.count)
            Spacer()
            DeleteButton {
                deleteAllFiles = true
            }
            .actionSheet(isPresented: $deleteAllFiles) {
                ActionSheet(
                    title: Text(String.actionText),
                    message: Text(String.actionMessage),
                    buttons:[
                        .destructive(Text(String.actionOK), action: removeAllFiles),
                        .cancel(Text(String.cancel))
                    ]
                )
            }
            .disabled(isLoading || galleryFiles.isEmpty)
        }
    }
}
*/
