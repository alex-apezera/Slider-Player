//
//  ProfileModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.04.2023.
//

// MARK: - Image transfer to Profile Avatar

import SwiftUI
import PhotosUI

@MainActor
class ProfileModel: ObservableObject {
        
    enum ImageState {
        case empty
        case retrieve
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    struct ProfileImage: Transferable {
        let image: Image
                
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
            #if canImport(AppKit)
                guard let nsImage = NSImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
                print("AppKit import is active")
                return ProfileImage(image: image)
            #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                print("UIKit import is active")
                return ProfileImage(image: image)
            #else
                throw TransferError.importFailed
            #endif
            }
        }
    }
    
    @Published var imageState: ImageState = .retrieve
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
        
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

