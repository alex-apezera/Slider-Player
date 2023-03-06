//
//  SentView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

struct SentView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(0 ..< 10) {_ in
                    FeedCell()
                }
            }
        }
    }
}

struct SentView_Previews: PreviewProvider {
    static var previews: some View {
        SentView()
    }
}
