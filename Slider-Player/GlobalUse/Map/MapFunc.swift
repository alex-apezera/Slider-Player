//
//  ExtensionMap.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.01.2024.
//

import MapKit
import SwiftUI

//MARK: Additional functions to MapView

extension MapView {
    func removeResults(){
        searchedResults.removeAll()
        searchedDistance = "0.0"
        searchedTime = 0
    }
    
    func directions(result: MKMapItem){
        directionsOn = !directionsOn
        if directionsOn{
            isSearching = true
            direction.sourceLocation = regionDefault.center
            direction.finalDestination = selectedResult.placemark.coordinate
        }
        isSearching = false
    }
    
    func locationButtonTapped(){
        selectedResult = MKMapItem()
        searchedResults.removeAll()
        searchedDistance = "0.0"
        searchedTime = 0
        if let location = locationManager.location {
            regionDefault = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            let currentLocation = MKMapItem(placemark: MKPlacemark(coordinate: location))
            selectedResult =  currentLocation
        }
    }
    
    func selectLocation(result : MKMapItem){
        selectedResult = result
    }
    
    func searchButtonTapped() {
        isSearching = true
        searchedDistance = "0.0"
        searchedTime = 0
        
        searchedResults.removeAll()
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchQuery
        if searchByCoordinates { request.region = MKMapView().region }
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            self.isSearching = false
            if let error = error {
                print(#function, "Error: \(error)")
                return
            }
            guard let response = response else {
                print(#function, "No response")
                return
            }
            for mapItem in response.mapItems {
                searchedResults.append(mapItem)
            }
            if searchedResults.count > 0 {
                selectedResult = searchedResults[0]
            }
        }
    }
    
    func searchByCoordinatesTapped() {
        searchByCoordinates = true
        searchButtonTapped()
        searchedDistance = "0.0"
        searchedTime = 0
    }
    
    func photoObjectButtonTapped() {
        let data = metaDataModel.metaDataObject[index]
        isPhotoObjectButtonTapped.toggle()
        searchedResults.removeAll()
        searchedDistance = "0.0"
        searchedTime = 0
        searchQuery = data.address
        destinationLocation = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
        /// get photo object image
        photoObjectImage = imageOnMap(url: data.url)
    }
}
