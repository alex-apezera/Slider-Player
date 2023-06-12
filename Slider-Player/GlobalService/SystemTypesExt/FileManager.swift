//
//  FileManager.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.04.2023.
//

import Foundation

extension FileManager {
    
    //MARK: - Create new folder for music files

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static let musicFilesDir = FileManager.getDocumentsDirectory().appendingPathComponent("Music Files")
        
    //MARK: - Property and methods for Image Gallery
    /// The URL of the document directory.
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    /// Copies the specified file URL to a file with the same name in the document directory.
    ///
    /// - parameter url: The file URL to be copied.
    ///
    /// - returns: The URL of the copied or existing file in the documents directory, or nil if the copy failed.
    ///
    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        guard let documentDirectory else { return nil }
        let pathExtension = sourceURL.pathExtension
//        let fileName = sourceURL.lastPathComponent
        let fileName = "\(randomString(length: idLength)).\(pathExtension)"
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print(#function, "Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    /// Create new file URL in the document directory.
    ///
    /// - returns: The URL of the created  file in the document directory or nil if the create failed.
    ///
    func createFileInDirectory(name: String) -> URL? {
        guard let documentDirectory else { return nil }
        let fileName = "\(name).jpeg"
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    /// Removes an item with the specified file URL from the document directory, if present.
    ///
    /// - parameter url: The file URL to be removed.
    ///
    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print(#function, "Unable to remove file: \(error.localizedDescription)")
            }
        }
    }
    
    /// Returns the contents of the specified directory as an array of URLs.
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        // The URL must be a directory.
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print(#function, "Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }

}

