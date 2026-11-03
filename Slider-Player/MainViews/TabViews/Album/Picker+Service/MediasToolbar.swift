//
//  ToolBar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.04.2024.
//

//MARK: - ToolBarContent for ImagePicker

import SwiftUI
import PhotosUI

extension MediasPicker {
        
    @ToolbarContentBuilder
    func toolbarImagePicker() -> some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            HStack {
                
                //MARK: - Get objects from Photolibrary
                getNewObjects

                //MARK: - Capturing & save the photo
                NavigationLink(destination: CapturedPhotoView().environmentObject(metaDataModel)) {
                    Label(String.capturingPhoto, systemImage: "camera")
                }
            }
            .disabled(isLoading || isEditing)
        }
        
        ToolbarItemGroup(placement: .topBarLeading) {
            
//MARK: - Edit Album items
            Button {
                withAnimation(.spring(duration: 0.8, bounce: 0.6)) {
                    isEditing.toggle()
                }
            } label: {
                Image(systemName: isEditing ? "pencil.slash" : "pencil")
                    .foregroundColor(isEditing ? .yellow : .accentColor)
            }
            .disabled(metaDataModel.metaDataObject.isEmpty || isLoading)
            
//MARK: - Remove all Album items to trash
            Button {
                isRemoveAll = true
            } label: {
                Image(systemName: "trash")
            }
            .actionSheet(isPresented: $isRemoveAll) {
                ActionSheet(
                    title: Text(String.actionText),
                    message: Text(String.actionMessage),
                    buttons:[
                        .destructive(Text(String.actionOK), action: removeAllImages),
                        .cancel(Text(String.cancel))
                    ]
                )
            }
            .disabled(metaDataModel.metaDataObject.isEmpty || isLoading)
        }
    }
}
