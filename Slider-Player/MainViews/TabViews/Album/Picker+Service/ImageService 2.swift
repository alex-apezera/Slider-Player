//
//  ImageService.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.01.2024.
//
import SwiftUI

//MARK: - Remove Images from Photo library

extension MediasPicker {
    
    //MARK: - Remove Button
    @ViewBuilder
    func removeButton(_ metaData: MetaData) -> some View {
        if isEditing {
            Button {
                withAnimation {removeSelectedImage(metaData: metaData)}
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(Font.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .red)
            }
            .offset(x: 7, y: -7)
        }
    }
    
    //MARK: - Remove all images from the Image Gallery.
    func removeAllImages() {
        lastIndex = metaDataModel.metaDataObject.count
        for index in 0..<lastIndex {
            let fileUrl = metaDataModel.metaDataObject[index].url
            withAnimation {removeSelectedObject(url: fileUrl)}
        }
        metaDataModel.metaDataObject.removeAll() /// Delete object from memory
        storeMetaDataObject(metaDataModel.metaDataObject) /// Store empty meta data to URL
//        removeMetaDataObject() /// Delete MetaDataObject  URL
        lastIndex = 0
    }
    
    //MARK: - Remove an image from the Image Gallery.
    func removeSelectedImage(metaData: MetaData) {
        var data = metaDataModel.metaDataObject
        if let index = data.firstIndex(where: {$0.id == metaData.id}) {
            let fileUrl = data[index].url
            withAnimation { removeSelectedObject(url: fileUrl) }
            data.remove(at: index)
            storeMetaDataObject(data) /// Store  meta data to URL without selected one
            lastIndex = data.count
        }
    }
}

