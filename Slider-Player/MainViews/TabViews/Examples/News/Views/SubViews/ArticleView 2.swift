//
//  ArticleView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 21.11.2024.
//

import SwiftUI

struct ArticleView: View {
    
    //MARK: - Properties
    let article: Article
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    //MARK: - Body
    var body: some View {
        VStack{
            if let url = article.urlToImage, let imageURL = URL(string: url) {
                
                AsyncImage(url: imageURL) {image in
                    image.resizable().scaledToFill()
                        .frame(width: frameWidth, height: frameHeight)
                        .cornerRadius(.articleCorner)
                } placeholder: {
                    PlaceHolder(frameHeight: frameHeight)
                }
            }
            VStack(alignment: .leading) {
                
                Text(article.title).titleMode
                Spacer()
                Text(article.publishedAt.convertingToString).descriptionMode
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: frameWidth, height: frameWidth == frameHeight ? frameWidth*2 : frameWidth)
        .padding(.articleCorner)
        .background(.background)
        .cornerRadius(.articleCorner)
    }
}
