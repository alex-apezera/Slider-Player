//
//  BackButtonView.swift
//  NewsApp
//
//  Created by Алексей Езерский on 20.11.2024.
//

import SwiftUI

struct BackButton: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    //MARK: - Body
    var body: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Circle().frame(width: 34).opacity(0.3).foregroundStyle(.black)
                Image(systemName: "chevron.left").font(.title3).foregroundStyle(.white).fontWeight(.medium).opacity(0.8)
            }
        }
        .padding()
    }
}

#Preview {
    BackButton()
}
