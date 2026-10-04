//
//  firstFrame.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI

// use this as to call image
@ViewBuilder
public func firstFrame(_ movie: URL, size: CGFloat) -> some View {
    if let uiimage =  imageFromVideo(url: movie, at: 0) {
        let image = Image(uiImage: uiimage)
        image.resizable()
            .frame(width: size, height: size)
            .cornerRadius(8)
//            .scaledToFill()
            .shadow(radius: 3)
            .overlay(alignment: .bottomLeading) {
                let duration = getVideoDuration(from: movie)
                if !duration.isEmpty {
                    Text(duration).font(.caption2).background(.thinMaterial).foregroundStyle(.white).offset(x: 3, y: -3).underline(false)
                }
            }
    }
}
