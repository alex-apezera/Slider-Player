//
//  URL.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import SwiftUI

extension URL {
    
//    static var galleryDirectory = FileManager.imageGalleryDir
//    
//    static var galleryJSONFile = FileManager.imageGalleryDir.appendingPathComponent("gallery.json")


    // Convert and store uiimage to URL
    func saveUIImage(_ uiimage: UIImage?) async {
        if let uiimage {
            if let data = uiimage.jpegData(compressionQuality: UserSettings().jpegCompression) {
                try? data.write(to: self)
            }
        } else {
            print(#function, "UIImage is nil, so try removing file \(self)")
            try? FileManager.default.removeItem(at: self)
        }
    }
    
    // Retrieve uiimage from URL
    func loadUIImage(_ uiimage: inout UIImage?) {
        if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
            uiimage = loaded
        } else {
            print(#function, "Couldn't load UIImage from URL: \(self)")
            uiimage = nil
        }
    }
    
    // Indicates whether the URL has a file extension corresponding to a common image format. Use in Image Gallery.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
    
    var isAudio: Bool {
        let audioExtensions: Set<String> = ["mp3", "wav", "aac", "m4a"]
        return audioExtensions.contains(self.pathExtension)
    }
    
    var isVideo: Bool {
        let videoExtensions: Set<String> = ["mp4", "mov", "avi", "mkv", "webm"]
        return videoExtensions.contains(self.pathExtension)
    }

}
