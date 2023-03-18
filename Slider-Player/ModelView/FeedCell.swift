//
//  FeedCell.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//
/*
 Подготовка к работе с массивом ячеек на примере одной ячейки
 Запуск Презентации (Плеера)
 */

import SwiftUI

struct FeedCell: View {
    var post: Post
    @State var isPreview = false
    @ObservedObject var piece = Piece()
    @ObservedObject var feedPosts = FeedViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                Image(post.ownerImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipped()
                    .cornerRadius(22)
                Text(post.ownerUserName).font(.system(size: 14, weight: .semibold))
            }.padding([.leading, .bottom], 8)
            
            // post picture
            // action buttons
            HStack(spacing: 16) {
                Button(action: {
                    withAnimation {
                        self.isPreview.toggle()
                        let index = feedPosts.posts.firstIndex(where: {$0.image == post.image})
                        piece.pieceIndex = index ?? 0
                    }

                }, label: {
                    Image(post.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                        .clipped()
                        .cornerRadius(10)
//                        .animation(Animation.spring(response: 3.5, dampingFraction:  4.5, blendDuration: 5.6))
                })
                .buttonStyle(.borderless)
                .sheet(isPresented: $isPreview) {
                    PieceInfo()
                        .environmentObject(piece)
                        .environmentObject(AudioManager())
                }
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            
            // likes
            Text("\(post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            // caption
                Text(post.caption).font(.system(size: 14))
            .padding(.horizontal, 8)
            
            // time stamp
            Text(post.timestamp).font(.system(size: 14)).foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }.padding()
    }
}
