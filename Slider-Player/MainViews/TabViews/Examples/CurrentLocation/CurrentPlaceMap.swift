//
//  CurrentPlaceMap.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 16.08.2024.
//

import SwiftUI
import MapKit

struct CurrentPlaceMap: View {
    let coordinate: CLLocationCoordinate2D
    private var place: CurrentPlace
    @State private var region = MKCoordinateRegion()

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.place = CurrentPlace(id: UUID(), coordinate: coordinate)
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place]) { place in            MapMarker(coordinate: coordinate, tint: .red)
        }
        .onAppear {
            withAnimation {
                region.center = coordinate
                region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            }
        }
    }
}

struct CurrentPlace: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
}
