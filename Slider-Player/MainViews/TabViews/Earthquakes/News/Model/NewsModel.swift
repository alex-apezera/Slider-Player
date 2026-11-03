//
//  NewsModel.swift
//  NewsApp
//
//  Created by Алексей Езерский on 17.11.2024.
//
// JSON model of data

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
}

//MARK: - true options

// API key: 566a2e3a390e437faa594ca0525111c6

//country=us

//category=business
//category=music
//category=sport
//category=politics

//q=tesla
//q=apple
//q=putin
//q=crypto

//from=2024-11-22
//to=2024-11-22

//sortBy=popularity
//sortBy=publishedAt

//sources=techcrunch

//domains=wsj.com

