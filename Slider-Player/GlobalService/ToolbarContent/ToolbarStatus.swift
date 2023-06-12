//
//  ToolbarStatus.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.05.2024.
//  Last Editing on 5.11.2024.

import SwiftUI

//MARK: - Status of list item with localized date-time
struct ToolbarStatus: View {
    var title: String
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var count: Int

    var body: some View {
        VStack {
            if isLoading {
                Text("\(.checkingFor) \(title)...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(count) \(title)")
                    .foregroundStyle(Color.secondary)
            } else {
                let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
                Text("\(String.updated) \(lastUpdatedDate.formatted(.relative(presentation: .named).locale(Locale(identifier: locale))))")
                Text("\(count) \(title)")
                    .foregroundStyle(Color.secondary)
            }
        }
        .frame(width: 200)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .font(.caption)
    }
}
