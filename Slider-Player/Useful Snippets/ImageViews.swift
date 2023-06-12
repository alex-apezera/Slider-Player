//
//  ImageViews.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.12.2023.
//

/*
import SwiftUI

struct ImageViews: View {
    @AppStorage("showImage") var showImage = false
    @AppStorage("showImages") var showImages = false
    @AppStorage("lastIndex") var lastIndex = 0

    let spacing: CGFloat = 20

    var body: some View {
        Button {
            showImage = true
        } label: {
            HStack(spacing: spacing) {
                Image(systemName: "photo")
                Text("Image")
            }
        }
        .sheet(isPresented: $showImage) {
            MyPhotoPicker()
        }
        
        Button {
            showImages = true
        } label: {
            HStack(spacing: spacing) {
                Image(systemName: "photo.stack")
                Text("Images = \(String(lastIndex))")
            }
        }
        .fullScreenCover(isPresented: $showImages) {
            MyPhotosPicker()
        }
    }
}
*/
