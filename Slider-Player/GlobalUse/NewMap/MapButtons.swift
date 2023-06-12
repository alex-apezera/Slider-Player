//
//  MapButtons.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 24.01.2024.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct MapButtons: View {
    @Binding var position: MapCameraPosition
    @Binding var searchResults: [MKMapItem]
    var visibleRegion: MKCoordinateRegion?
    var newRegion: MKCoordinateRegion?
    @Binding var showPhoto: Bool
    @Binding var needGetMarker: Bool
    @Binding var needSearchQuery: Bool
    @Binding var searchQuery: String
    @Binding var startRoutePoint: Bool
    @Binding var reverseRoute: Bool
    @Binding var startFromCL: Bool
    @Binding var mediaURLs: [URL]
    @Binding var photoObjectCoordinates: [CLLocationCoordinate2D]
    @Binding var selectedResult: MKMapItem?
    @Binding var selectedPhotoObject: MKMapItem?
    @Binding var selectedTapItem: MKMapItem?
    @Binding var hybridStyle: Bool
    @Binding var startNewMap: Bool

    let userPoint = CurrentPoint()
    
    @ObservedObject var regionModel = RegionModel()
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(center: userPoint.currentCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        Task {
            let search = MKLocalSearch(request: request)
            let responce = try? await search.start()
            searchResults = responce?.mapItems ?? []
        }
    }
 //MARK: - Bottom Buttons
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    HStack {
                        Button {withAnimation {startNewMap = false}
                        } label: {Image(systemName: "xmark.circle")}
                            .foregroundStyle(.pink).opacity(0.6)
                        
                        Button {withAnimation {showPhoto.toggle()}
                        } label: {Image(systemName: "photo.stack")}
                            .foregroundStyle(showPhoto ? .yellow : .green)
                            .disabled(MetaDataModel().metaDataObject.isEmpty)

                        Button { withAnimation {
                            selectedResult = nil
                            selectedPhotoObject = nil
                            selectedTapItem = nil
                            photoObjectCoordinates.removeAll()
                            mediaURLs.removeAll()
                            searchResults.removeAll()}
                        } label: { Image(systemName: "mappin.slash") }
                            .foregroundStyle(.orange)
                        
                        Button { startRoutePoint.toggle()
                        } label: { Image(systemName: startRoutePoint ? "car.fill" : "car") }
                            .foregroundStyle(startRoutePoint ? .yellow : .green)
                        
                        Button { reverseRoute.toggle()
                        } label: { Image(systemName: "arrow.down.left.arrow.up.right") }
                            .foregroundStyle(reverseRoute ? .yellow : .green)
                        
                        Button { needGetMarker.toggle()
                        } label: { Image(systemName: "rectangle.and.hand.point.up.left") }
                            .foregroundStyle(needGetMarker ? .yellow : .green)
                        
                        Button { startFromCL.toggle()
                        } label: { Image(systemName: startFromCL ? "location.fill.viewfinder" : "location.viewfinder")}
                            .foregroundStyle(startFromCL ? .orange : .green)
                        
                        Button { withAnimation {needSearchQuery.toggle()}
                        } label: { Image(systemName: "plus.magnifyingglass")}
                            .foregroundStyle(needSearchQuery ? .orange : .white)

                        Button { search(for: .market)
                        } label: { Image(systemName: "storefront") }
                        
                        Button { search(for: .museum)
                        } label: { Image(systemName: "building.columns") }
                        
                        Button { search(for: .restaurant)
                        } label: { Image(systemName: "fork.knife") }
                        
                        Button { search(for: .hotel)
                        } label: {Image(systemName: "bed.double")}
                        
                        Button {search(for: .playground)
                        } label: { Label(String.playground, systemImage: "figure.and.child.holdinghands") }
                        
                        Button { search(for: .beach)
                        } label: { Label(String.beach, systemImage: "beach.umbrella") }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    HStack {
                        Button { withAnimation {
                            position = .region(newRegion!)
                            }
                        } label: {
                            Label(String.newRegion, systemImage: "mappin.and.ellipse")
                        }
                        .disabled(newRegion == nil)
                        
                        Button {
                            hybridStyle.toggle()
                        } label: {
                            Image(systemName: "mountain.2")
                        }

                        ForEach(regionModel.regionItems) {item in
                            Button { withAnimation {
                                position = .region(item.regionCity ?? .moscow)}
                            } label: {
                                Text(item.regionName)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding(5)
                .labelStyle(.iconOnly)
            }
        }
        .onChange(of: searchQuery) { oldValue, newValue in
                search(for: newValue)
        }
    }
}
