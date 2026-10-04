//
//  WeatherDetailItem.swift
//  Weathered
//
//  Created by christian on 7/24/23.
//

import SwiftUI

struct WeatherDetailRowView: View {
    let metric: String
    let unit: String
    let value: Double
    
 //MARK: - Detail View row of a property metric
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                iconRendering(value, for: metric)
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(.trailing, 15)
                    .opacity(0.8)
                
                Text(metric)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack (alignment: .bottom, spacing: 8){
                    Text(String(Int(value)))
                        .fontWeight(.medium)
                    
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 48, height: 20)
                        .overlay {
                        HStack {
                            Text(unit)
                                .opacity(0.8)
                            Spacer()
                        }
                    }
                }
            }
            .font(.headline)
            .fontWeight(.light)
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical, 6)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.white.opacity(0.1))
                .padding(.leading, 51)
                .padding(.trailing, 60)
        }
        .padding(.leading, 4)
    }
}
