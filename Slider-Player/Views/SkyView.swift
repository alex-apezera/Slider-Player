//
//  SkyView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.03.2023.
//
/*
 Извлекает из интернета и показывает изображение путём AsyncImage
 Также показывает индикатор ожидания загрузки
*/
import SwiftUI

struct SkyView: View {
    
    var body: some View {
        
        VStack {
            
            AsyncImage(url: URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg")) { phase in
                if let image = phase.image {
                    image // Displays the loaded image.
                        .resizable().scaledToFit()
                        .frame(height: UIScreen.main.bounds.height / 1.1)
                    
                } else if phase.error != nil {
                    ZStack {
                        Color.red // Indicates an error.
                        Text("Error. Image from WEB not loaded.")
                    }
                } else {
                    ProgressView()  // ProgressView indicator
                        .foregroundColor(.white)
                }
            }.padding(.bottom)
                    
        }
    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView()
        
    }
}
