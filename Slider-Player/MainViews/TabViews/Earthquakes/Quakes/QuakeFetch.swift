//
//  QuakeFetch.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.10.2026.
//

import SwiftUI
extension Quakes {
    
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return .capQuakes
        } else {
            return "\(selection.count) \(String.selected)"
        }
    }
    func deleteQuakes(at offsets: IndexSet) {
        provider.deleteQuakes(atOffsets: offsets)
    }
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchQuakes() async {
        do {
            try await provider.fetchQuakes()
            DispatchQueue.main.async {
                quakesCount = provider.quakes.count
                lastUpdated = Date().timeIntervalSince1970
            }
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            hasError = true
        }
    }
}
