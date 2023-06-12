//
//  ApplyGradient.swift
//  NewsApp
//
//  Created by Алексей Езерский on 20.11.2024.
//


import SwiftUI

struct ApplyGradient: View {
    var body: some View {
        LinearGradient(colors: [Color(UIColor.systemBackground), .clear], startPoint: .bottom, endPoint: .top)
            .frame(height: SizeConstants.avatarHeight / 4)
            .offset(y: -SizeConstants.avatarHeight / 4)
    }
}
