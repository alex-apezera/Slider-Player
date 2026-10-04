//
//  SelectedFileView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2025.
//

import SwiftUI

struct SelectedFileView: View {
    let size: Double
    let url: URL

    var body: some View {
        
        if url.isImage {
            SelectedImageView(size: size, url: url)
        } else {
            firstFrame(url, size: size)
        }
    }
}
