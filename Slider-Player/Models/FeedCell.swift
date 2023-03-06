//
//  FeedCell.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

struct FeedCell: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                Image(post.ownerImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                Text(post.ownerUserName).font(.system(size: 14, weight: .semibold))
            }.padding([.leading, .bottom], 8)
            
            // post picture
            Image(post.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.size.width)
                .frame(maxHeight: UIScreen.main.bounds.size.width)
                .clipped()
            
            // action buttons
            HStack(spacing: 16) {
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .resizable()
                        .feedModifier()
                })
                Button(action: {}, label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .feedModifier()
                })
                Button(action: {}, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .feedModifier()
                })
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            
            // likes
            Text("\(post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            // caption
            HStack {
                Text(post.ownerUserName).font(.system(size: 14, weight: . semibold))
                Text(post.caption).font(.system(size: 14))
            }
            .padding(.horizontal, 8)
            
            // time stamp
            Text(post.timestamp).font(.system(size: 14)).foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }.padding()
    }
}
