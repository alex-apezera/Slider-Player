//
//  ExtensionItemInfoView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.02.2024.
//

//MARK: - ItemInfo functions

import SwiftUI
import MapKit

extension ItemInfoView {
    
    func getLookAroundScene(mapItem: MKMapItem) {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: mapItem)
            lookAroundScene = try? await request.scene
        }
    }
    
//    func getPlacemarkInfo(mapItem: MKMapItem) {
//        locationName = ""
//        locationAddress = ""
//        guard let latitude = mapItem.placemark.location?.coordinate.latitude else {return}
//        guard let longitude = mapItem.placemark.location?.coordinate.longitude else {return}
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        let getInfo = GetInfo(name: $locationName, address: $locationAddress)
//        getInfo.convertCoordinateToInfo(location)
//        location2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
    
    func getPlacemarkInfo(mapItem: MKMapItem) {
        locationName = ""
        locationAddress = ""

        guard let location = mapItem.location as CLLocation? else { return }
        guard CLLocationCoordinate2DIsValid(location.coordinate) else { return }

        let getInfo = GetInfo(name: $locationName, address: $locationAddress)
        Task { await getInfo.convertCoordinateToInfo(location) }
        location2D = location.coordinate
    }

    
    var placeInfo: some View {
        VStack(spacing: 10) {
            if selectedResult.name != .unknownLocation {
                Text(selectedResult.name ?? "")
            } else {
                Text(locationName)
            }
            if selectedResult.phoneNumber != "" {
                Text(selectedResult.phoneNumber ?? "")
            }
//            if selectedResult.placemark.title != "United States" {
//                if selectedResult.placemark.title != "Russia" {
//                    Text(selectedResult.placemark.title ?? "")
//                }
//            }
            Text(verbatim: .addressFromMarkerLocation).foregroundStyle(.tertiary)
            Text(locationAddress)
            HStack {
                Text(coord2String(coordinate: location2D))
                ElevationView(coordinate: location2D)
            }
            .font(.footnote).foregroundStyle(.tertiary)
        }
        .padding(10)
    }
    
    var sidebarInfo: some View {
        VStack {
            WeatherButton(icon: "openweathermap") {
                showOpenWeatherInfo.toggle()
            }
            WeatherButton(icon: "weatherapi") {
                showWeatherInfo.toggle()
            }

            AnyButton(icon: "questionmark.app") {
                showPlaceInfo.toggle()
            }
            .padding(.top,1)
            .font(.title)
        }
    }
    
    var selectedLocationInfo: some View {
        VStack {
            if selectedResult.name != .unknownLocation {
                Text(selectedResult.name ?? locationName)
            } else {
                Text(locationName)
            }
        }
        .padding(.trailing, 10)
        .padding(.top, 10)
    }
    
    var routeInfo: some View {
        VStack {
            if let distance {Text("\(distance)\(.km)")}
            if let travelTime {Text(travelTime)}
        }
        .padding(.trailing, 10)
        .padding(.top, 10)
    }
}
