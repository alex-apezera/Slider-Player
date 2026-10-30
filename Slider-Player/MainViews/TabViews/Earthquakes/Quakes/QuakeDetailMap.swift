/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    private var place: QuakePlace
    @State private var region = MKCoordinateRegion()
    @State private var position: MapCameraPosition = .automatic

    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(location: location)
    }

    var body: some View {
        
        // Deprecated
//        Map(coordinateRegion: $region, annotationItems: [place]) { place in MapMarker(coordinate: place.location, tint: tintColor)
//        }
//        .onAppear {
//            withAnimation {
//                region.center = place.location
//                region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//            }
//        }
        
        // Quake marker
        Map(position: $position) {
//            ForEach([place]) { place in
                Marker(String.quakePlace, coordinate: place.location)
                    .tint(tintColor)
//            }
        }
        .onAppear {
            withAnimation {
                position = .region(MKCoordinateRegion(
                    center: place.location,
                    span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                ))
            }
        }

    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D

    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}
