//
//  NewsView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 17.11.2024.
//

import SwiftUI

struct NewsView: View {
    
    //MARK: - Properties
    @StateObject var viewModel: NewsViewModel = .init()
    @AppStorage("querry") var query = "tesla"
    @AppStorage("category") var category = "business"
    @AppStorage("newsCount") var newsCount: Int = 0
    
    //MARK: - Body
    var body: some View {
        
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: - Top News
                TitleView(title: "\(String.topNews): \(viewModel.topNews.count)")
                
                QueryView(promprt: .category, category: $category)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.topNews, id: \.self) { article in
                            NavigationLink(destination: DetailView(article: article)) {
                                ArticleView(article: article, frameWidth: .topArticleFrameWidth, frameHeight: .topArticleFrameHeight)
                            }.buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .shadow(color: .black.opacity(0.3), radius: 12, x: 5, y: 8)
                
                //MARK: - Bottom News
                TitleView(title: "\(String.allNews): \(viewModel.bottomNews.count)")
                
                QueryView(promprt: .query, category: $query)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.bottomNews, id: \.self) { article in
                            NavigationLink(destination: DetailView(article: article)) {
                                ArticleView(article: article, frameWidth: .bottomArticleFrameSize, frameHeight: .bottomArticleFrameSize)
                            }.buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .shadow(color: .black.opacity(0.3), radius: 12, x: 5, y: 8)
            }//ScrollView
            .background(.secondary.opacity(0.3))
            .refreshable {
                viewModel.fetchTopNews()
                viewModel.fetchBottomNews()
            }
            .onChange(of: viewModel.topNews.count) { newValue in
                newsCount = newValue + viewModel.bottomNews.count
            }
            .onChange(of: viewModel.bottomNews.count) { newValue in
                newsCount = viewModel.topNews.count + newValue
            }
        }//VStack
        
        .navigationModifier(String.news)
    }
}

#Preview {
    NewsView()
}
