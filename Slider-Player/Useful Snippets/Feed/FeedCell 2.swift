//
//  FeedCell.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.

// closed 21/021/2025
/*

//MARK: - Prepare one cell of Feed

import SwiftUI

struct FeedCell: View {
    var post: Post
    @ObservedObject var piece = Piece()
    @ObservedObject var feedPosts = FeedViewModel()
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                Image(post.ownerImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .cornerRadius(22)
                Text(post.ownerUserName).font(.system(size: 14, weight: .semibold))
            }.padding([.leading, .bottom], 12)
            
            // post picture
            // action buttons
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(post.image)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                        .padding(12)
                }
                .buttonStyle(.borderless)
                .onAppear {
                    let index = feedPosts.posts.firstIndex(where: {$0.image == post.image})
                    piece.pieceIndex = index ?? 0
                }
            // likes
            Text("\(post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 12)
                .padding(.bottom, 2)
            
            // caption
                Text(post.caption).font(.system(size: 14))
            .padding(.horizontal, 12)
            
            // time stamp
            Text(post.timestamp).font(.system(size: 14)).foregroundColor(.gray)
                .padding(.leading, 12)
        }
        .padding()
        .sheet (isPresented: $isPlaying) {
            PieceInfo()
                .environmentObject(piece)
                .environmentObject(AudioManager())
        }
    }
}
*/
