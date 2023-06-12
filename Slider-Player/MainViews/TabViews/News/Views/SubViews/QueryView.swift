//
//  QueryView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 24.11.2024.
//

import SwiftUI

struct QueryView: View {
    let promprt: String
    @Binding var category: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(promprt, text: $category)
        }
        .padding(5)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
        .background(.ultraThinMaterial)
        .shadow(radius: 5)
        .cornerRadius(15)
        .font(.body)
        .lineLimit(.max)
        .multilineTextAlignment(.leading)
        .keyboardType(.emailAddress)
        .padding(.horizontal)

    }
}
