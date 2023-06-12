//
//  GalleryAsset.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.02.2025.
//
/*
import SwiftUI
import PhotosUI

struct GalleryAsset {
    
    @Binding var refreshView: Bool
    
    @ObservedObject var galleryObject: GalleryObject = GalleryObject()
    
    @Binding var date: Date
    @Binding var placeName: String
    @Binding var address: String
    @Binding var latitude: CLLocationDegrees
    @Binding var longitude: CLLocationDegrees
    
    func takeData(from newItem: PhotosPickerItem, at id: String) async throws {
        var asset = AssetModel(id: id, date: date, address: address, placeName: placeName, latitude: latitude, longitude: longitude)
                
        if let localID = newItem.itemIdentifier {
            let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
            if let asset = result.firstObject {
                placeName = "?"
                print("\n", #function, "GOT ASSET: " + asset.debugDescription)
            }
            ///Date
            if let objectDate = result.firstObject?.creationDate {
                date = objectDate
            }
            ///Placemark
            if let coordinate  = result.firstObject?.location?.coordinate {
                let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                latitude = coordinate.latitude
                longitude = coordinate.longitude
                
                location.placemark { placemark, error in
                    guard let placemark else {
                        print("\n", #function, "Error: Placemark not defined", error ?? "nil"); return }
                    // Title and Address of Place
                    placeName = placemark.name ?? ""
                    address = placemark.streetName ?? ""
                    address += " \(placemark.streetNumber ?? "")"
                    address += " \(placemark.city ?? "")"
                    address += " \(placemark.neighborhood ?? "")"
                    address += " \(placemark.state ?? "")"
                    address += " \(placemark.zipCode ?? "")"
                    address += " \(placemark.country ?? "")"
                    print("\n", "Placemark = \(placemark)")
                }
            }
        } else {
            print("\n", #function, "localID is invalid")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            asset = AssetModel(id: id, date: date, address: address, placeName: placeName, latitude: latitude, longitude: longitude)
            withAnimation {refreshView.toggle()}
            galleryObject.assets.insert(asset, at: 0)
            storeGalleryAssets(galleryObject.assets)
            print("\n", #function, "asset: \(asset)")
        })
    }
}
*/
