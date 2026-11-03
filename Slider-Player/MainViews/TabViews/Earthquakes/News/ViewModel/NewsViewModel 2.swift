//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Алексей Езерский on 18.11.2024.
//

import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var topNews: [Article] = []
    @Published var bottomNews: [Article] = []
    
    @AppStorage("querry") var query = "tesla"
    @AppStorage("category") var category = "business"

    init() {
        fetchTopNews()
        fetchBottomNews()
    }
    
    //MARK: - Methods
    func fetchTopNews() {
        Task {
            do {
                let data = try await NetworkManager.shared.getNews(urlString: .hiNews(for: category))
                topNews = data.articles
            } catch {
                if let error = error as? NetworkError {
                    print(#function, error)
                }
            }
        }
    }
    func fetchBottomNews() {
        Task {
            do {
                let data = try await NetworkManager.shared.getNews(urlString: .allNews(for: query))
                bottomNews = data.articles
            } catch {
                if let error = error as? NetworkError {
                    print(#function, error)
                }
            }
        }
    }
}
