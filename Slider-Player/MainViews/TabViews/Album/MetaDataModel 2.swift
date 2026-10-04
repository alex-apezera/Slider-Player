//
//  MetaData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.10.2023.
//

import SwiftUI
import CoreLocation

struct MetaData: Codable, Identifiable, Equatable {
    var id: String
    var date: Date
    var address: String
    var placeName: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var url: URL
}
@MainActor
final class MetaDataModel: ObservableObject {
    @Published var metaDataObject = [MetaData]()
    
    init() {load()}
    
    func load() {
        metaDataObject = retrieveMetaDataObject()
        
        //MARK: - Add file url from document directory
        // This is actually for iOS devices
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { [$0.isImage, $0.isVideo].contains(true) }
            
            for url in urls {
                if let index = metaDataObject.firstIndex(where: {$0.url.lastPathComponent == url.lastPathComponent}) {
                    metaDataObject[index].url = url
                    print("\n", #function, "INDEX: \(index), URL: \(url)")
                } else {
                    print("\n", #function, "NOT FOUND INDEX, URL: \(url)")
                }
            }
        }
    }
}
