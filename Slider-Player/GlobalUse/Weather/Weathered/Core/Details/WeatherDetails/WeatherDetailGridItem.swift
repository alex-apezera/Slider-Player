//
//  WeatherDetailGridItem.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import SwiftUI

struct WeatherDetailGridItem: View {
    let metric: String
    let value: String
    
    var frameWidth: Double {
        switch metric {
        case .sunrise, .sunset:
            return 36
        case .moonrise, .moonset:
            return 30
        default:
            return 30
        }
    }
    
    var offset: Double {
        switch metric {
        case .sunset, .sunrise:
            return -3
        default:
            return 0
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundTopStops.interpolated(amount: 0.1).opacity(0.1))
                    .frame(width: 70, height: 70)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))

                VStack {
                    iconRendering((value as NSString).doubleValue, for: metric)
                        .imageScale(.large)
                        .frame(width: frameWidth, height: frameWidth)
                        .padding(.bottom, 2)
                    Text(value)
                        .font(.caption2)
                        .offset(y: offset)
                }
            }
            Text(metric)
                .font(.caption2)
                .shadow(radius: 3)
        }
    }
}
