//
//  TitleView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 21.11.2024.
//

import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        Text(title).font(.title).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.top)
    }
}
