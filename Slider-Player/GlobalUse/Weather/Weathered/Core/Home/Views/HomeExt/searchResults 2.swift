//
//  searchResults.swift
//  Weathered
//
//  Created by Алексей Езерский on 13.09.2024.
//

import SwiftUI
@available(iOS 17.0, *)
extension HomeView {
    
    var searchResultsView: some View {
        VStack(alignment: .leading) {
            
            Text("\(Int(weatherVM.weatherData?.current.tempC ?? 0))°")
                .font(.system(size: 70))
                .foregroundStyle(.white)
                .fontDesign(fontDesign)
            
            
            Text(weatherVM.weatherData?.location.name.prefix(25) ?? "")
                .font(.largeTitle)
                .fontDesign(fontDesign)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text(weatherVM.weatherData?.location.region ?? "")
                .font(.title2)
                .foregroundColor(.lightCloudEnd)
                .lineLimit(1)
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 1.5)){
                if isSearching {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                viewingDetails = true
            }
        }
    }
}
