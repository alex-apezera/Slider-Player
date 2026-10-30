//
//  MetaDataService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.11.2024.
//

import SwiftUI
import MapKit
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
                    guard let request = MKReverseGeocodingRequest(location: location) else { return }
                    do {
                        guard let mapItem = try await request.mapItems.first else { return }

                        let addressRep = mapItem.address
                        metaData.address = addressRep?.fullAddress ?? ""
                        metaData.placeName = mapItem.name ?? ""
                        print("🆕", #function, metaData.placeName, metaData.address)
                    } catch {
                        print("⭕️", #function,"Placemark not defined", error)
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
