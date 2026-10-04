//
//  WeatherApiView.swift
//  Weathered
//
//  First borrowed from christian on 7/26/23.
//

import SwiftUI
import SwiftData

struct WeatherApiView: View {
    @State var coordinates: String = ""
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    @Binding var viewingDetails: Bool
    @State private var fontDesign: Font.Design = .default
    
    @ViewBuilder var conditionsView: some View {
        if let weatherData = weatherVM.weatherData {
            ConditionsView(viewingDetails: $viewingDetails, weatherData: weatherData, fontDesign: fontDesign)
        }
    }
        
    var body: some View {
        VStack {
            if viewingDetails {
                conditionsView
            } else {
                if coordinates.isEmpty {
                    if #available(iOS 17.0, *) {
                        HomeView(viewingDetails: $viewingDetails, fontDesign: $fontDesign)
                            .environmentObject(LocationViewModel())
                    }
                }
            }
        }
        .onAppear {
            weatherVM.query = coordinates
            if !coordinates.isEmpty { weatherVM.fetchWeatherData() }
            print(#function, weatherVM.query)
        }
        .environmentObject(weatherVM)
        .navigationModifier(String.weather)
    }
}
