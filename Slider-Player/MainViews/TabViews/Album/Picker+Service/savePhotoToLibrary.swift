//
//  savePhotoToLibrary.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.03.2025.
//

import SwiftUI
extension CapturedPhotoView {
    /// Copy photo to `PhotosLibrary` button using disappearing message
    @ToolbarContentBuilder
    func savePhotoToLibraryIcon() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            Button {
                saveToPhotoLibrary.toggle()
                showMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { showMessage = false
                }
            } label: {
                Image(systemName:saveToPhotoLibrary ? "rectangle.portrait.slash" : "ipad.and.arrow.forward")
                    .foregroundStyle(saveToPhotoLibrary ? .yellow : .green)
            }
        }
    }
    
}
