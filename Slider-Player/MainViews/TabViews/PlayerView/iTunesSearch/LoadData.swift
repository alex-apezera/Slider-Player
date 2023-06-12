//
//  LoadData.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.08.2024.

//MARK: - Fetch data from iTunes.apple.com

import Foundation

extension SearchView {
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchRequest)&entity=song") else {
            print(#function, "Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
                resultsCount = self.results.count
            }
        } catch {
            print(#function, "Invalid data: \(error)")
        }
    }
}
