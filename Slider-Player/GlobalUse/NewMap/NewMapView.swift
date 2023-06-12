//
//  NewMapView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 24.01.2024.
//
// First code get from Apple Forum

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct NewMapView: View {
    @Binding var startNewMap: Bool
    
    @ObservedObject var metaDataModel = MetaDataModel()
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var userPoint = CurrentPoint()

    @State var showPhoto = false
    @State var needGetMarker = false
    @State var needSearchQuery = false
    @State var startRoutePoint = false
    @State var reverseRoute = false
    @State var startFromCL = false
    @State var hybridStyle = false
    
    @State var searchQuery = ""
    @State var query = ""
    @State var locationAddress = ""
    @State var locationName = ""
    @State var photoObjectCoordinate = CLLocationCoordinate2D()
    @State var photoObjectCoordinates: [CLLocationCoordinate2D] = []
    @State var mediaURL: URL?
    @State var mediaURLs: [URL] = []

    @State var position: MapCameraPosition = .automatic
    @State var visibleRegion: MKCoordinateRegion?
    @State var newRegion: MKCoordinateRegion?
    @State var span: CLLocationDegrees = 0.15
    @State var spanText: String = "0.15"

    @State var searchResults: [MKMapItem] = []
    @State var selectedResult: MKMapItem?
    @State var selectedPhotoObject: MKMapItem?
    @State var selectedTapItem: MKMapItem?
    @State var route: MKRoute?
    @State var startPoint: MKMapItem?
        
    let gradient = LinearGradient(colors: [.red, .green, .blue], startPoint: .leading, endPoint: .trailing)
    let stroke = StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: [4, 4])

    var body: some View {
        MapReader { reader in
            Map(position: $position, selection: $selectedResult) {
                
//MARK: - Parking Marker if exist startPoint
                if let startPoint {
                    let parkingPoint = startPoint.placemark.coordinate
                    Marker(String.parking, systemImage: "car.fill", coordinate: parkingPoint)
                        .tint(.mint)
                        .mapOverlayLevel(level: .aboveLabels)
                }
//MARK: - Photo Marker of object
                ForEach(0..<mediaURLs.count, id: \.self) { index in
                    Annotation(String.photo, coordinate: photoObjectCoordinates[index]) {
                        photoObjectAnnotation(item: index)
                    }
                    .mapOverlayLevel(level: .aboveLabels)
                    .annotationTitles(.hidden)
                }
                
//MARK: - Calculate direction of route
                if let route {
                    MapPolyline(route)
                        .stroke(gradient, style: stroke)
                }
//MARK: - All Markers
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                .annotationTitles(.hidden)
                
//MARK: - User Current location
                UserAnnotation()
            }
//MARK: - Manage block
            .mapStyle(hybridStyle ? .hybrid(elevation: .realistic) : .standard(elevation: .realistic))
            .mapControls {
                mapControlButtons()
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
            .safeAreaInset(edge: .bottom) {
                infoToolBar()
            }
            .onChange(of: searchResults) {
                route = nil
                position = .automatic
            }
            .onChange(of: selectedResult) {
                getDirections()
            }
            .onChange(of: selectedPhotoObject) {
                withAnimation {
                    if let selectedPhotoObject, let mediaURL {
                        searchResults.append(selectedPhotoObject)
                        mediaURLs.append(mediaURL)
                        photoObjectCoordinates.append(photoObjectCoordinate)
                    }
                }
            }
            .onChange(of: selectedTapItem) {
                if let selectedTapItem {
                    withAnimation {searchResults.append(selectedTapItem)}
                }
            }
            .onChange(of: reverseRoute) {
                getDirections()
            }
            .onChange(of: startRoutePoint) {
                if let selectedResult {
                    startPoint = selectedResult
                    getDirections()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    startRoutePoint = false })
            }
            .onChange(of: startFromCL) { withAnimation {
                startPoint = MKMapItem(placemark: MKPlacemark(coordinate: userPoint.currentCoordinate))
                getDirections() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    startFromCL = false })
            }
            .onTapGesture { screenCoord in
                if needGetMarker {
                    selectedTapItem = getMarkerItem(reader: reader, screenCoord: screenCoord)
                    needGetMarker = false
                }
            }
        }
        .navigationModifier(String.newMap)
    }
}
