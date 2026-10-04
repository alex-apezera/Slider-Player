//
//  ArticlePlaceholder.swift
//  NewsApp
//
//  Created by Алексей Езерский on 21.11.2024.
//

import SwiftUI

struct PlaceHolder: View {
    let frameHeight: CGFloat
    var body: some View {
        ZStack {
            Rectangle()
            Image(systemName: "photo").resizable().scaledToFit()
                .frame(height: frameHeight/1.5)
        }
        .frame(height: frameHeight).opacity(0.3)
        .foregroundStyle(.secondary)
        .cornerRadius(.articleCorner)
    }
}

#Preview {
    PlaceHolder(frameHeight: SizeConstants.avatarHeight)
}
