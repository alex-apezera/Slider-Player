//
//  MetaData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 18.10.2023.
//

import SwiftUI
import PhotosUI

struct MetaData: Codable, Identifiable, Equatable {
    var id: String
    var date: Date
    var info: String
    var note: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var url: URL
}

class MetaDataModel: ObservableObject {
    @Published var metaDataObject = [MetaData]()
    
    init() {
        metaDataObject = retrieveMetaDataObject()
//        print(#function, "lastIndex->", metaDataObject.count, "id->", metaDataObject.map{$0.id}, "\n")
    }
}

