//
//  DetailView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 19.11.2024.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Properties
    let article: Article
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical, showsIndicators: false) {
                MainImage(article: article)
                
                MainText(article: article)
            }
            .ignoresSafeArea()
//            .navigationBarHidden(true)
            
            if !iPadDevice { BackButton() }
                        
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    DetailView(
        article: .init(
            title: "Title",
            description: "Description",
            url: "URL",
            urlToImage: "https://picsum.photos/200",
            publishedAt: .init()
        )
    )
}

