//
//  MainImageView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 19.11.2024.
//

import SwiftUI

struct MainImage: View {
    
    //MARK: - Properties
    let article: Article
    var offsetY: CGFloat { iPadDevice ? -30 : 10 }
    
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            if let url = article.urlToImage, let imageURL = URL(string: url) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    PlaceHolder(frameHeight: SizeConstants.avatarHeight)
                }
                .aspectRatio(contentMode: iPadDevice ? .fit : .fill)
                .offset(y: -geometry.frame(in: .global).minY)
                .frame(width: SizeConstants.screenWidth, height: geometry.frame(in: .global).minY + SizeConstants.avatarHeight + offsetY, alignment: iPadDevice ? .topLeading : .center)
            }
        }
        .frame(height: SizeConstants.avatarHeight)
    }
}
