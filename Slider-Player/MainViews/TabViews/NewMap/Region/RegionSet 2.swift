//
//  Region.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.02.2024.

//MARK: Coordinate of Regions

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {

    static let homeParking = CLLocationCoordinate2D(latitude: 55.72070674353212, longitude: 37.581642064997745)
}

extension MKCoordinateRegion {
    static let boston = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.360256, longitude: -71.057279),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    static let northShore = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.547408, longitude: -70.870085),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    static let moscow = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.72070674353212, longitude: 37.581642064997745),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    static let newYork = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.77948354, longitude: -73.96258870),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    static let sanFrancisco = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.76431865, longitude: -122.43861121),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    static let london = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.50646225, longitude: -0.07394691),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    static let bangkock = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.73662656, longitude: 100.55793559),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    static let vien = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.20819244, longitude: 16.37484983),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    static let peterburg = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.93900787, longitude: 30.31536916),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
}

