//
//  GetMetaData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 03.11.2026.
//
/*
import SwiftUI
import PhotosUI
import MapKit

struct GetMetaData {
    @State var selectedItems = [PhotosPickerItem]()
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("lastUpdatedObject") var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")
    
    func getImagesWithData(from items: [PhotosPickerItem], into model: MetaDataModel) async throws {
        
        for item in items {
            
            /// Default (initial) MataData value with initiation id value
            let id = randomString(length: idLength)
            var metaData = MetaData(id: id, date: Date(), address: "", placeName: "", latitude: 0, longitude: 0, url: URL(fileURLWithPath: ""))
            
            /// Get MetaData asset from PhotoLibrary
            if let localID = item.itemIdentifier {
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
                model .metaDataObject.insert(metaData, at: 0)
            }

   
        }
    }
}
*/
