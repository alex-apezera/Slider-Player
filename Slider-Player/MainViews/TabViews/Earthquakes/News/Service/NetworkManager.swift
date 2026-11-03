//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Алексей Езерский on 17.11.2024.
//

import Foundation

final class NetworkManager {
    
    //MARK: - Properties
    static let shared = NetworkManager()
    private let decoder: JSONDecoder = .init()
    
    //MARK: - Initializer
    private init() { decoder.dateDecodingStrategy = .iso8601 }
    
    //MARK: - Methods
    func getNews(urlString: String) async throws -> News {
        
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        do {
            return try decoder.decode(News.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
