//
//  ShowImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import SwiftUI

struct ShowImage: View {
    let item: Item
    
    var body: some View {
        
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(10  )
            /// Место для вставки кода захвата изображения
        } placeholder: {
            ProgressView()
        }
    }
}
