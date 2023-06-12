//
//  MetaDataService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.11.2024.
//

import SwiftUI
import PhotosUI

//MARK: - Get and store MetaDataobjects

extension MediasPicker {

    func getImagesWithData(from newItems: [PhotosPickerItem]) async throws {
        for item in newItems {
            
            /// Default (initial) MataData value with initiation id value
            let id = randomString(length: idLength)
            var metaData = MetaData(id: id, date: Date(), address: "", placeName: "", latitude: 0, longitude: 0, url: URL(fileURLWithPath: ""))
            
            /// Get MetaData asset from PhotoLibrary
            selectedItem = item
            if let newItem = selectedItem, let localID = newItem.itemIdentifier {
                let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                if let asset = result.firstObject {
                    print(#function, "GOT ASSET: " + asset.debugDescription)
                }
                /// Date of captuting photo
                if let imageDate = result.firstObject?.creationDate {
                    metaData.date = imageDate
                }
                /// Get Coordinate if exist
                if let coordinate  = result.firstObject?.location?.coordinate {
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    metaData.latitude = coordinate.latitude
                    metaData.longitude = coordinate.longitude
                    // Placemark
                    location.placemark { placemark, error in
                        guard let placemark else { print("\n", #function, error ?? "Placemark not defined"); return }
                        // Title and Address of Place
                        metaData.placeName = placemark.name ?? ""
                        metaData.address = placemark.streetName ?? ""
                        metaData.address += " \(placemark.streetNumber ?? "")"
                        metaData.address += " \(placemark.city ?? "")"
                        metaData.address += " \(placemark.neighborhood ?? "")"
                        metaData.address += " \(placemark.state ?? "")"
                        metaData.address += " \(placemark.zipCode ?? "")"
                        metaData.address += " \(placemark.country ?? "")"
                    }
                }
            }
            /// URL for store Image & video
            guard let documentDirectory = documentDirectory else {return}
            copyFile = documentDirectory.appendingPathComponent("\(metaData.id)")

            /// Try import images or videos from Photolibrary depending on item
            if let photo = try? await item.loadTransferable(type: Photo.self) {
                metaData.url = photo.url
            }
            if let movie = try? await item.loadTransferable(type: Movie.self) {
                metaData.url = movie.url
            }
 /* old scheme
            metaData.url = documentDirectory.appendingPathComponent("\(metaData.id).jpeg")
            // Get photos from Selected item and store to URL
            if let data = try? await item.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    await metaData.url.saveUIImage(uiImage)
                }
            }
  */
            // Insert reseived or default MetaData to MetaDataObject Array
            withAnimation {
                metaDataModel.metaDataObject.insert(metaData, at: 0)
            }
        } /// end for item...
    }
        
    func getAndStoreMetaData(_ items: [PhotosPickerItem]) {
        Task {
            do {
                isLoading = true
                try await getImagesWithData(from: items)
                // Store MetaDataObject
                storeMetaDataObject(metaDataModel.metaDataObject)
                // Number of Objects
                lastIndex = metaDataModel.metaDataObject.count
                // Signal then loadind is completion
                isLoading = false
                // Elimination duplication when re-entering to the Picker
                selectedItems.removeAll()
                // Refresh date of Loading
                lastUpdatedObject = Date().timeIntervalSince1970
            } catch {
                print("\n", #function, "Error: \(error)")
            }
        }
    }
}
