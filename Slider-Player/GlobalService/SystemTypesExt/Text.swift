//
//  Extension+Text.swift
//  NewsApp
//
//  Created by Алексей Езерский on 18.11.2024.
//

import SwiftUI

extension Text {
    
    var titleMode: some View {
        self.font(.system(size: 16, weight: .bold, design: .rounded)).foregroundStyle(.primary).opacity(0.8)
    }
    
    var descriptionMode: some View {
        self.font(.system(size: 14, weight: .regular, design: .rounded)).foregroundStyle(.primary).opacity(0.8)
    }
    
    static func dataDescription(_ placeName: String, _ address: String, _ date: Date) -> some View {
        VStack {
            Self(placeName)
                .font(.title3).bold().foregroundStyle(.primary)
            Self(address)
                .font(.footnote).foregroundStyle(.primary).padding(.bottom, 5)
            Self(date.formatted(customDateStyle()))
                .foregroundStyle(.secondary).bold().padding(.bottom, 10)
        }
    }
    
    static func fileDescription(_ date: Date, _ placeName: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Self(date.formatted(customDateStyle())).font(.footnote)
                .foregroundStyle(.secondary)
            Self(placeName)
                .font(.caption).bold().foregroundStyle(.primary)
        }
    }
}
