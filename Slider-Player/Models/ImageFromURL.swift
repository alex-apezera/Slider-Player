//
//  ImageFromURL.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.03.2023.
//

import SwiftUI

struct ImageFromURL: View {
    
    @ObservedObject private var getImageFromWeb = GetImageFromWeb()

    var body: some View {
        HStack {
            Image(uiImage: getImageFromWeb.imageView.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {getImageFromWeb.getImagePressed()}
        }.environmentObject(getImageFromWeb)
    }
}

struct ImageFromURL_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromURL()
    }
}
