//
//  BackGroundImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.09.2024.
//
//MARK: -  image from Web

import SwiftUI

struct BackGroundImage: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: .imageFromWeb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
        }
//        .frame(height: UIScreen.main.bounds.height / 1.3)
        .cornerRadius(15)
        .padding(10)
    }
}

extension String {
    static let imageFromWeb =
    "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
}

#Preview {
    BackGroundImage()
}
