//
//  MapResults.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.08.2024.
//

import SwiftUI
extension MapView {
    
// MARK: - Show results and directions
    func showMapResultsAndDirections() -> some View {
        ScrollView(.horizontal){
            HStack {
                if !searchedResults.isEmpty && !hideResults {
                    ForEach(searchedResults, id: \.self) { result in
                        
                        VStack(alignment: .center, spacing: 5) {
                            Text(result.placemark.name ?? .unknownLocation)
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .padding()
                            Text(result.placemark.title ?? .unknownLocation)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 14))
                                .lineLimit(3)
                                .padding(.horizontal)
                                .padding()
                            HStack {
                                Spacer()
                                Text("\(.distance) \(searchedDistance as String) \(.km),")
                                Text("\(.time) \(DateComponentsFormatter.abbreviated.string(from: searchedTime) ?? "0:00")")
                                Spacer()
                            }
                            .font(.system(size: 12))
                            HStack {
                                selectLocationButton(result)
                                Spacer()
                                hideResultsListButton()
                                Spacer()
                                showDirectionsButton(result)
                            }
                            .padding()
                        }
                        .frame(maxWidth: 300, minHeight: 200)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        .padding()
                        .buttonStyle(.borderless)
                    }
                }
            }
            .padding()
            .shadow(radius: 10, x: 0, y: 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
