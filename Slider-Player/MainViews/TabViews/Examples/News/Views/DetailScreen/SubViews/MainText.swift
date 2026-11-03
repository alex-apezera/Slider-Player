//
//  MainText.swift
//  NewsApp
//
//  Created by Алексей Езерский on 21.11.2024.
//

import SwiftUI

struct MainText: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: .articleSpacing) {
            Text(article.title).titleMode
            if let description = article.description {
                Text(description).descriptionMode
            }
            Text(article.publishedAt.convertingToString).descriptionMode
        }
        .padding(.horizontal)
        .padding(.top, .articleSpacing)
        .padding(.bottom, .articleSpacing/2)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .background(ApplyGradient())
    }
}
