//
//  FeedCell.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                Image("Alisa")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                Text("Alisa").font(.system(size: 14, weight: .semibold))
            }.padding([.leading, .bottom], 8)
            
            // post picture
            Image("Egipt")
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
            Text("2 likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            // caption
            HStack {
                Text("Alisa and Elya.").font(.system(size: 14, weight: . semibold))
                Text("In Egipt very good!").font(.system(size: 14))
            }
            .padding(.horizontal, 8)
            
            // time stamp
            Text("2 month ago").font(.system(size: 14)).foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
        }.padding()
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
