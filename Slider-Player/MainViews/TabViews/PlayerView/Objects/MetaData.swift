//
//  MetaData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.10.2023.
//

import SwiftUI
import PhotosUI

struct MetaData: Codable, Identifiable, Hashable {
    var id = UUID()
    var date: Date
    var info: String
    var note: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}

func saveMetaDataObject(_ metadataObject: [MetaData]) {
    let data = metadataObject.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "metaDataKey")
}

func loadMetaDataObject() -> [MetaData] {
    guard let encodedData = UserDefaults.standard.array(forKey: "metaDataKey") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(MetaData.self, from: $0) }
}

func removeMetaDataObject() {
    UserDefaults.standard.removeObject(forKey: "metaDataKey")
}

class MetaDataModel: ObservableObject {
    @Published var metaDataObject = [MetaData]()
    
    init() {
        metaDataObject = loadMetaDataObject()
        print(#function, "lastIndex->", metaDataObject.count, "id->", metaDataObject.map{$0.id}, "\n")
    }
}
