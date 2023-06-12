//
//  favoriteLocations.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//
//MARK: - Favorite locations

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    var favoriteLocationsView: some View {
        VStack {
            if !favoriteLocations.isEmpty {
                HStack {
                    Text(verbatim: .favoriteLocations)
                        .font(.callout)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.leading)
                        .padding(.bottom, -10)
                    Spacer()
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(favoriteLocations) { location in
                        FavoriteLocationTile(location: location, fontDesign: fontDesign, viewingDetails: $viewingDetails)
                        
//MARK: - Delete location if need
                            .contextMenu {
                                Button {
                                    modelContext.delete(location)
                                } label: {
                                    Label(String.delete, image: "trash")
                                }
                                .onTapGesture(count: 1) {
                                    hideResults()
                                }
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Button {
                                    withAnimation { modelContext.delete(location)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.pink).opacity(0.25).padding(5).offset(y: -16)
                                }
                            }
                    }//ForEach
                }//HStack
                .padding(.leading)
            }//Scroll
        }//VStack
    }//favoriteLocationsView
}
