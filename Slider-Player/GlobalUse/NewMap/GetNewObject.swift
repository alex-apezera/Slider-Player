//
//  GetNewObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.11.2026.
//

import SwiftUI
import PhotosUI

extension MediasPicker {
    
    /// Get new media objects from user medialibrary (using Album)
    var getNewObjectsIntoAlbum: some View {
        VStack {
            if isEditing && gridMode {
                ColumnStepper(title: columnsTitle, range: 1...8, columns: $flexibleColumns)
                    .padding()
            }
            ScrollView {
                LazyVGrid (columns: gridMode ? flexibleColumns : adaptiveColumns, spacing: Self.itemSpacing) {
                    ForEach(metaDataModel.metaDataObject) { metaData in
                        GeometryReader { geo in
                            NavigationLink {
                                selectedObjectView(metaData)
                            } label: {
                                SelectedFileView(size: gridMode ? geo.size.width : Self.itemSize.width, url: metaData.url)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {removeButton(metaData)}
                    }
                }
                .padding()
            }
        }
        .titleInline(String.imagesGallery)
        .navigationViewStyle(.stack)
        .toolbar {toolbarImagePicker()}/// Take data & edit Album
    }
    
    /// Get new media objects from user medialibrary (using NewMap)
    var getNewObjects: some View {
        
        PhotosPicker(selection: $selectedItems, photoLibrary: .shared()) {
            if isLoading {
                ProgressView()
            } else {
                Image(systemName: "plus.square.on.square")
            }
        }
    }

}
