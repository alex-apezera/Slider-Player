//
//  MyMap.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.06.2023.
//
//  First borrowed from Jakub Jelinek on 11/03/2023. (GitHub -jakjel/Maps-SwiftUI)

import SwiftUI
import MapKit

// So i can communicate between views, i have to use Representable-Controller/Coordinator
struct MapModel: UIViewRepresentable {
    @Binding var errorMessage: String
    @Binding var searchedResults: Array<MKMapItem>
    @Binding var selectedResult: MKMapItem
    @Binding var regionDefault : MKCoordinateRegion
    @Binding var directionsOn: Bool
    @Binding var direction: Direction
    @Binding var searchedDistance: String
    @Binding var searchedTime: TimeInterval
    @Binding var destinationLocation: CLLocationCoordinate2D
    @Binding var searchByCoordinates: Bool
    
    // Creates the view object and configures its initial state.
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    // Updates the state of the specified view with new information from SwiftUI.
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        mapView.removeAnnotations(mapView.annotations)
        if !searchedResults.isEmpty {
            if selectedResult !== MKMapItem(){
                let coordinates = searchByCoordinates ? destinationLocation : selectedResult.placemark.coordinate
                let region = MKCoordinateRegion(center: coordinates, span: span)
                let customAnnotation = CustomAnnotation(
                    title: selectedResult.placemark.name,
                    locationName: selectedResult.placemark.title,
                    coordinate: coordinates)
                mapView.addAnnotation(customAnnotation)
                mapView.setRegion(region, animated: true)
            } else {
                searchedResults.forEach {
                    result in
                    let coordinates = searchByCoordinates ? destinationLocation : result.placemark.coordinate
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    let customAnnotation = CustomAnnotation(
                        title: result.placemark.name,
                        locationName: result.placemark.title,
                        coordinate: coordinates)
                    mapView.addAnnotation(customAnnotation)
                    mapView.setRegion(region, animated: true)
                }
            }
        } else {
            let customAnnotation = CustomAnnotation(
                title: "",
                locationName:  "",
                coordinate: regionDefault.center)
            mapView.addAnnotation(customAnnotation)
            mapView.setRegion(regionDefault, animated: true)
        }
        if directionsOn {
            mapView.removeOverlays(mapView.overlays)
            let sourceMapItem = MKMapItem(placemark: MKPlacemark(coordinate: direction.sourceLocation!))
            let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: searchByCoordinates ? destinationLocation : direction.finalDestination!))
            
            let customAnnotation = CustomAnnotation(
                title: "",
                locationName: "",
                coordinate: regionDefault.center)
            mapView.addAnnotation(customAnnotation)
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
//            directionRequest.requestsAlternateRoutes = true
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { response, error in
                guard let response else { return }
                
//                for route in response.routes {  /// second variant
                let route = response.routes[0]  /// first variant
                mapView.addOverlay(route.polyline, level: .aboveRoads)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                let distance = String(format: "%.1f", route.distance / 1000)
                let timeInterval = route.expectedTravelTime
                
                searchedDistance = distance
                searchedTime = timeInterval
                
                print(#function, "Расстояние до места: \(distance) км.")
                print(#function, "Время в пути составит: \(timeInterval) c.")
//                }   /// delete this if "first variant"
            }
            
            let region = MKCoordinateRegion(center: direction.sourceLocation!, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
        }
        else {
            mapView.removeOverlays(mapView.overlays)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: .location)
            annotationView.markerTintColor = .systemRed
            annotationView.glyphImage = UIImage(systemName: "mappin")
            return annotationView
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5.0
            return renderer
        }
    }
}

class Direction {
    var sourceLocation: CLLocationCoordinate2D?
    var finalDestination: CLLocationCoordinate2D?
    
    init(){
            // Empty implementation
        }
    
    init(sourceLocation: CLLocationCoordinate2D, finalDestination: CLLocationCoordinate2D) {
        self.sourceLocation = sourceLocation
        self.finalDestination = finalDestination
    }
}


