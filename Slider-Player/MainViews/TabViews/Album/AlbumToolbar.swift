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
    func albumToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
//MARK: - Select Photo Object(s)
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(metaDataModel.metaDataObject.map {$0.id})
                    } else {
                        selection = []
                    }
                }
            }
//MARK: - Call MediasPicker
            NavigationLink { MediasPicker(isLoading: $isLoading).environmentObject(metaDataModel)
            } label: { Image(systemName: "rectangle.grid.3x2.fill") }
        }
//MARK: - Editing Mode
        ToolbarItem(placement: .topBarLeading) {
            EditingButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
//MARK: - Bottom State String
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                metaDataModel.metaDataObject = retrieveMetaDataObject()
                lastUpdatedObject = Date().timeIntervalSince1970
            }
            Spacer()
            ToolbarStatus(title: .images, isLoading: isLoading, lastUpdated: lastUpdatedObject, count: lastIndex)
            Spacer()
            if editMode == .active {
                DeleteButton {
                    deleteImageObjects(for: selection)
                }
                .disabled(isLoading || selection.isEmpty)
            }
        }
    }
}
