//
//  FeedView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.

// closed 21/021/2025
/*
//MARK: - Feed + Player

import SwiftUI

struct FeedView: View {
    @ObservedObject var feedViewModel = FeedViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(feedViewModel.posts) {post in
                    if #available(iOS 17.0, *) {
                        FeedCell(post: post)
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                    .opacity(phase.isIdentity ? 1.0 : 0.0)
                            }
                    } else {
                        FeedCell(post: post)
                    }
                }
                .padding([.leading, .trailing, .top], -20)
            }
            .padding(.top)
        }
        .navigationModifier(String.menuItemFeed)
        .background(.secondary.opacity(0.3))
    }
}

#Preview {
    FeedView()
}
*/
