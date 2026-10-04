//
//  ArtworkView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 12.06.2024.

//MARK: - Album cover

import SwiftUI

struct ArtworkView: View {
    let size: Double
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Image(systemName: "waveform.circle").resizable()
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: size < 100 ? size / 5 : 20))
        .shadow(radius: 3)
    }
}
