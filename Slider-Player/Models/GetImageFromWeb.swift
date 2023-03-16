//
//  GetImageFromWeb.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.03.2023.
//

import SwiftUI
import UIKit

class GetImageFromWeb: ObservableObject {
    
    @Published public var imageView: UIImageView = UIImageView(image: UIImage(systemName: "network"))
        
    public func getImagePressed() {
                
    guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}

