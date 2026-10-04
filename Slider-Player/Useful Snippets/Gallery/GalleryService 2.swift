//
//  GalleryService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 13.02.2025.
//
/*
import SwiftUI

//MARK: - Create subdirectory imageGalleryDir

public func setImageGallery() {
    var isDirectory: ObjCBool = false
    guard FileManager.default.fileExists(atPath: FileManager.imageGalleryDir.path, isDirectory: &isDirectory), isDirectory.boolValue else { return }

    do {
        try FileManager.default.createDirectory(at: FileManager.imageGalleryDir, withIntermediateDirectories: true, attributes: nil) ///See Utility/Extensions
    } catch {
        print("Failed to create folder: \(FileManager.imageGalleryDir)")
        print(#function, error.localizedDescription)
    }
    
}

public func setGalleryJSONFile() {
    var isDirectory: ObjCBool = false
    guard FileManager.default.fileExists(atPath: URL.galleryJSONFile.path, isDirectory: &isDirectory), isDirectory.boolValue else { return }

   FileManager.default.createFile(atPath: URL.galleryJSONFile.path, contents: .none) ///See Utility/Extensions
}

//MARK: - Retrieve Videos & Photos from FileManager

public func getGalleryFiles(_ items: inout [URL]) {
    var isDirectory: ObjCBool = false
    guard FileManager.default.fileExists(atPath: FileManager.imageGalleryDir.path, isDirectory: &isDirectory), isDirectory.boolValue else { return }
    do {
        // fetch all data from document directory...
        let urls = try FileManager.default.contentsOfDirectory(at: URL.galleryDirectory, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
        
        // updated means remove all old data..
        items.removeAll()
        
        for url in urls {
            if url.isVideo || url.isImage {
                items.append(url)
//                print(#function, "Success to append File:",  url)
            }
        }
    } catch {
        print(#function, error.localizedDescription)
    }
}

// MARK: - Gallery objects/FileManager

// delete gallery object from FileManager
func removeGalleryObject() {
    let url = URL.galleryJSONFile
    do {
        try FileManager.default.removeItem(at: url)
        print(#function, "Successfully deleted Gallery Json File!", url)
    } catch {
        print(#function, "Error deleting Gallery Json File: \(error)")
    }
}

// store gallery object assets to FileManager
func storeGalleryAssets(_ assets: [AssetModel]) {
    let url = URL.galleryJSONFile
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(assets)
        try jsonData.write(to: url)
        print(#function, "Stored to: ", url.lastPathComponent)
    } catch {
        print(#function, "Error encoding data: \(error)")
    }
}

// Retrieve jsonData from the file using FileManager
func retrieveGalleryObject() -> [AssetModel] {
    var assets = [AssetModel]()
    let url = URL.galleryJSONFile
    do {
        let jsonData = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let readingData = try jsonDecoder.decode([AssetModel].self, from: jsonData)
        assets = readingData /// Use the `readingData` array in your app
//        print(#function,  "Retrieved from: ", url.lastPathComponent)
    } catch {
        print(#function, "Error decoding data: \(error)")
    }
    return assets
}


extension GalleryList {
        
    @ViewBuilder func deleteOrExport(_ file: URL) -> some View {
        
        //MARK: - export a track
        ShareLink(item: file, subject: Text(String.exportTrack)) {
            Image(systemName: "square.and.arrow.up").foregroundStyle(.cyan)
        }
        //MARK: - delete a track
        Button(role: .destructive ) {  withAnimation {
            removeFile(at: file) }
        } label: {
            Image(systemName: "trash")
        }

    }
    
    //MARK: - Remove an gallery file
    func removeFile(at item: URL) {
        if let index = galleryFiles.firstIndex(of: item) {
            do {
                try FileManager.default.removeItem(at: item)
                galleryFiles.remove(at: index)
                storeGalleryAssets(galleryObject.assets)
                lastUpdatedMovies = Date().timeIntervalSince1970
                print(#function, "Successfully deleted file -> \(item.lastPathComponent)")
            } catch {
                print(#function, "Error: file \(item.lastPathComponent) not exist")
            }
        }
    }
    
    //MARK: - Remove all gallery files
    func removeAllFiles() {
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: URL.galleryDirectory, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            for url in urls{
                if url.isVideo || url.isImage {
                    try FileManager.default.removeItem(at: url)
                    print(#function, "Successfully deleted file -> \(url.lastPathComponent)")
                }
            }
            galleryFiles.removeAll()
            removeGalleryObject()
        } catch {
            print(#function, "Error deleting files: \(error)")
        }
    }
    
    //MARK: - Refresh gallery with background queue

    func refresh() {
        startFileView = false
        getGalleryFiles(&galleryFiles)
        galleryFilesCount = galleryFiles.count
        DispatchQueue.global(qos: .background).async {startFileView = true}
    }
}
*/
