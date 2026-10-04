//
//  WeatherInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 03.08.2024.
//

import SwiftUI
import CoreLocation
//MARK: - Weather info view

func weatherInfo(for coordinate: CLLocationCoordinate2D) -> some View {
    GeometryReader { geo in
        ScrollView {
            WeatherInfo(customCoordinate: coordinate)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .position(x: geo.size.width/2, y: geo.size.height/2)
                .shadow(radius: 10)
        }
    }
}

struct WeatherInfo: View {
    @State var customCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @ObservedObject var locationManager = LocationManager()
    @State var forecastResponse: ForecastApiResponse?
    @State var weatherResponse: WeatherApiResponse?
    var userPoint = CurrentPoint()
    @State var getLocation = false
    @State var placeTitle = ""
    @State var timeZone: TimeZone?

    let dayCell: CGFloat = 90
    let tempCell: CGFloat = 70
    let descCell: CGFloat = 200
    let cloudsCell: CGFloat = iPadDevice ? 70 : 80
    let rainCell: CGFloat =  iPadDevice ? 85 : 95
    let windCell: CGFloat = iPadDevice ? 90 : 100
    let humidCell: CGFloat = 90
    let pressCell: CGFloat = iPadDevice ? 90 : 100
    let sunriseCell: CGFloat = iPadDevice ? 90 :100
    let sunsetCell: CGFloat = iPadDevice ? 90 :100
    let space: CGFloat = 10

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 5) {
                weatherContent
                forecastContent
            }
            .foregroundStyle(.secondary)
            .frame(width: iPadDevice ? 600 : 300)
            .frame(minHeight: iPadDevice ? 660 : 400)
            .background(.ultraThinMaterial)
            .onAppear {
                locationManager.requestLocation()
            }
            .onReceive(locationManager.$location) { coordinate in
                guard let coordinate else {return}
                let userCoordinate = customCoordinate.latitude.isZero && customCoordinate.longitude.isZero ? coordinate : customCoordinate
                fetchApiData(from: userCoordinate)
            }
        }
    }
}
