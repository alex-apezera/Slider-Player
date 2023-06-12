//
//  TransferService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.03.2025.
//
//MARK: - Transfer movie & image file from system photoLibraty
 
import SwiftUI

public func copyTransferredFile(_ received: ReceivedTransferredFile) -> URL {
    
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")

    let pathExtension = received.file.pathExtension
    let copy = copyFile.appendingPathExtension(pathExtension)
    if FileManager.default.fileExists(atPath: copy.path()) {
        do { try FileManager.default.removeItem(at: copy) }
        catch { print(error.localizedDescription) }
    }
    print("\n", #function, "received:", received, "\n", "copy:", copy)
    
    do { try FileManager.default.copyItem(at: received.file, to: copy) }
    catch { print(error.localizedDescription) }
    return copy
}

struct Movie: Transferable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            Self.init(url: copyTransferredFile(received))
        }
    }
}

struct Photo: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .image) { photo in
            SentTransferredFile(photo.url)
        } importing: { received in
            Self.init(url: copyTransferredFile(received))
        }
    }
}
