//
//  GridItemView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import SwiftUI

struct GridItemView: View {
    let size: Double
    let item: Item

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
            .cornerRadius(0)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "grizzly", withExtension: "jpg") {
            GridItemView(size: 350, item: Item(url: url))
        }
    }
}
