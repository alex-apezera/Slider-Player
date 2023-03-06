//
//  FeedView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var feedViewModel = FeedViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(feedViewModel.posts) {post in
                    FeedCell(post: post)
                }
                .padding([.leading, .trailing], -16)
            }
            .padding(.top)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
