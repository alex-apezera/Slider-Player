//
//  AlbumService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.05.2024.
//

import SwiftUI

extension AlbumView {
    
    /// Refresh status
    private func refreshStatus() {
        metaDataModel.metaDataObject = retrieveMetaDataObject()
        lastUpdatedObject = Date().timeIntervalSince1970

    }
    
    /// Delete at offsets
    func deleteImageObjects(at offsets: IndexSet) {
        var imageObjects = metaDataModel.metaDataObject
        for index in offsets {
            let fileUrl = imageObjects[index].url
            removeSelectedObject(url: fileUrl)
        }
        imageObjects.remove(atOffsets: offsets)
        storeMetaDataObject(imageObjects) /// Store  meta data to URL without selected one
        lastIndex = imageObjects.count
        refreshStatus()
    }
    
    /// Delete for index
    func deleteImageObjects(for codes: Set<String>) {
        let imageObjects = metaDataModel.metaDataObject
        var offsetsToDelete: IndexSet = []
        for (index, element) in imageObjects.enumerated() {
            if codes.contains(element.id) {
                offsetsToDelete.insert(index)
            }
        }
        deleteImageObjects(at: offsetsToDelete)
        selection.removeAll()
    }
    /// Move files
    func moveImageObjects(source: IndexSet, destination: Int) {
        var imageObjects = metaDataModel.metaDataObject
        imageObjects.move(fromOffsets: source, toOffset: destination)
        storeMetaDataObject(imageObjects)
        metaDataModel.metaDataObject = retrieveMetaDataObject()
    }
}

