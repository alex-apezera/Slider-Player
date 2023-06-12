//
//  DetailFileView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2025.
//

import SwiftUI

struct DetailFileView: View {
    let url: URL

    var body: some View {
        
        if url.isImage {
            DetailImageView(url: url)
        } else {
            MoviePlay(url: url)
        }
        
    }
}
