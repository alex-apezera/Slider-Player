//
//  SelectedImageView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 16.10.2023.
//
//MARK: - Show Image from MetaData.url

import SwiftUI

struct SelectedImageView: View {
    let size: Double
    let url: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
            .cornerRadius(8.0)
            .shadow(radius: 3)
        }
    }
}
