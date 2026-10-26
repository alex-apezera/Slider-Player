//
//  AlbumToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.04.2024.
//

import SwiftUI

extension AlbumView {
        
//MARK: - Refresh and Show Image Gallery
    
    @ToolbarContentBuilder
    var albumToolbar: some ToolbarContent {
                
        // Editing Mode
        ToolbarItemGroup(placement: .topBarLeading) {
            EditingButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
            if editMode == .active {
                DeleteButton {
                    withAnimation {
                        deleteImageObjects(for: selection)
                    }
                }
                .disabled(isLoading || selection.isEmpty)
            }

        }
        
        // Status string
        ToolbarItem(placement: .principal) {
            ToolbarStatus(title: .images, isLoading: isLoading, lastUpdated: lastUpdatedObject, count: lastIndex)
        }
        
        // Call MediasPicker
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink { MediasPicker(isLoading: $isLoading).environmentObject(metaDataModel)
            } label: { Image(systemName: "rectangle.grid.3x2.fill") }
        }

    }
}

//Snippet
// Select Photo Object(s)
//            if editMode == .active {
//                SelectButton(mode: $selectMode) {
//                    if selectMode.isActive {
//                        selection = Set(metaDataModel.metaDataObject.map {$0.id})
//                    } else {
//                        selection = []
//                    }
//                }
//            }

