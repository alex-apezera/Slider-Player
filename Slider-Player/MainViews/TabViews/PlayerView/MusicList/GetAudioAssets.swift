//
//  GetAugioAssets.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.05.2024.
//

//MARK: - Retrieve metadata from asset of Track

import SwiftUI
import AVKit

struct GetAudioAssets {
    let url: URL
    @Binding var albumTitle: String
    @Binding var composerName: String
    @Binding var songName: String
        
    func takeData() async throws {
        
        // Reset data
        albumTitle = ""
        composerName = ""
        songName = ""
        
        // A local or remote asset to inspect.
        let asset = AVAsset(url: url)
        
        // Load the asset's metadata.
//        let _ = try await asset.load(.metadata)
        
        // The collection of iTunes metadata.
        let iTunesMetadata = try await asset.loadMetadata(for: .iTunesMetadata)
        
        // Filter metadata to find the asset's album image.
        if let artworkItem = AVMetadataItem.metadataItems(from: iTunesMetadata, filteredByIdentifier:  .iTunesMetadataCoverArt).first {
            // Retrieve a Data object that contains the image data.
            guard let imageData = try await artworkItem.load(.dataValue) else { return }
            guard let uiImage = UIImage(data: imageData) else {return}
            await MusicFileManager().albumURL(from: url).saveUIImage(uiImage)
//            albumImage = Image(uiImage: uiImage)
        }
        // Filter metadata to find the asset's album title.
        if let albumItem = AVMetadataItem.metadataItems(from: iTunesMetadata, filteredByIdentifier:  .iTunesMetadataAlbum).first {
            guard let album = try await albumItem.load(.stringValue) else {return}
            albumTitle = album
        }
        // Filter metadata to find the asset's composer.
        if let composerItem = AVMetadataItem.metadataItems(from: iTunesMetadata, filteredByIdentifier:  .iTunesMetadataComposer).first {
            guard let composer = try await composerItem.load(.stringValue) else {return}
            composerName = composer
        }
        // Filter metadata to find the asset's song name.
        if let songItem = AVMetadataItem.metadataItems(from: iTunesMetadata, filteredByIdentifier:  .iTunesMetadataSongName).first {
            guard let song = try await songItem.load(.stringValue) else {return}
            songName = song
        }
    }
}
