//
//  DetailImageView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 03.05.2024.
//

import SwiftUI

struct DetailImageView: View {
    let url: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                NavigationLink {
                    GesturedImage(image: image)
                } label: {
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            } placeholder: {
                ProgressView()
            }
        }
    }
}

