//
//  QueryString.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.11.2024.
//

import Foundation

extension String {
    
//MARK: -  NewsApp
    //Api key
    /// Replace this string with my  API key  from the provided by newsapi.org.
    static let newsApiKey = "566a2e3a390e437faa594ca0525111c6"
    
    //request for category
    static func hiNews(for category: Self) -> Self {
        "https://newsapi.org/v2/top-headlines?category=\(category)&sortBy=publishedAt&apiKey=\(Self.newsApiKey)"
    }
    
    //request for querry
    static func allNews(for query: Self) -> Self {
        "https://newsapi.org/v2/everything?q=\(query)&sortBy=publishedAt&apiKey=\(Self.newsApiKey)"
    }
    
}
