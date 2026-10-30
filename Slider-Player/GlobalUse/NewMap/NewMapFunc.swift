//
//  ExtensionNewMap.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.02.2024.
//

//MARK: - Functions for manage map objects

import MapKit
import SwiftUI

extension NewMapView {
    
    func mapControlButtons() -> some View {
        VStack {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
            MapScaleView(anchorEdge: .leading)
        }
        .mapControlVisibility(.visible)
    }
    
    func getDirections() {
        route = nil

        let departurePoint = reverseRoute ? selectedResult : startPoint
        let destinationPoint = reverseRoute ? startPoint : selectedResult
        let request = MKDirections.Request()
        request.source = departurePoint
        request.destination = destinationPoint
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
        
    func getQueryAndSpan() -> some View {
        HStack {
            Button {
                withAnimation {searchQuery = query}
            } label: {Image(systemName: "magnifyingglass")}
            TextField(String.enterPointOfInterest, text: $query, axis: .horizontal)
            Spacer()
            Label(String.span, systemImage: "mappin.and.ellipse")
                .foregroundStyle(.secondary)
            TextField(String.enterDegrees, text: $spanText, axis: .horizontal)
        }
        .onChange(of: spanText) { _, newValue in
            let number = Double(newValue) ?? span
            let degree = CLLocationDegrees(number)
            span = degree
        }
        .buttonStyle(.borderless)
        .padding(.horizontal)
    }

    func infoToolBar() -> some View {
        HStack {
            VStack(spacing: 3) {
                if let selectedResult {
                    ItemInfoView(selectedResult: selectedResult, route: route)
                        .frame(height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                if showPhoto {
                    PhotoStackView(selectedPhotoObject: $selectedPhotoObject, locationAddress: $locationAddress, photoObjectCoordinate: $photoObjectCoordinate, mediaURL: $mediaURL)
                        .environmentObject(metaDataModel)
                }
                if needSearchQuery {
                    getQueryAndSpan()
                }
                MapButtons(position: $position, searchResults: $searchResults, visibleRegion: visibleRegion, newRegion: newRegion, showPhoto: $showPhoto, needGetMarker: $needGetMarker, needSearchQuery: $needSearchQuery, searchQuery: $searchQuery, startRoutePoint: $startRoutePoint, reverseRoute: $reverseRoute, startFromCL: $startFromCL, mediaURLs: $mediaURLs, photoObjectCoordinates: $photoObjectCoordinates, selectedResult: $selectedResult,selectedPhotoObject: $selectedPhotoObject, selectedTapItem: $selectedTapItem, hybridStyle: $hybridStyle, startNewMap: $startNewMap)
            }
            .padding([.top, .horizontal])
        }
        .background(.thinMaterial)
    }
        
    /// New placemark
    func getMarkerItem(reader: MapProxy, screenCoord: CGPoint) -> MKMapItem? {
        let coordinate = reader.convert(screenCoord, from: .local) ?? userPoint.currentCoordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        newRegion = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        )
        print(#function, newRegion!)

        return MKMapItem(location: location, address: nil)
    }

}
