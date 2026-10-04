//
//  MyMapView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 26.06.2023.
//
//  First borrowed from Jakub Jelinek on 11/03/2023. (GitHub -jakjel/Maps-SwiftUI)

import MapKit
import SwiftUI

struct MapView: View {
    let index: Int
    let hideSearchButton: Bool
    
    @EnvironmentObject var metaDataModel: MetaDataModel
    @ObservedObject var locationManager = LocationManager()
    @State var errorMessage: String = ""
    @State var searchQuery: String = ""
    @State var isSearching: Bool = false
    @State var isEditing = false
    @State var searchedResults: Array<MKMapItem> = []
    @State var selectedResult: MKMapItem = MKMapItem()
    @State var regionDefault : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.721, longitude: 37.582), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State var direction: Direction = Direction()
    @State var directionsOn : Bool = false
    @State var isPhotoObjectButtonTapped = false
    @State var photoObjectImage: Image = Image(systemName: "photo.circle.fill")
    @State var searchedDistance: String = "0.0"
    @State var searchedTime: Double = 0.0
    @State var destinationLocation: CLLocationCoordinate2D = .init(latitude: .zero, longitude: .zero)
    @State var hideResults = false
    @State var searchByCoordinates = false
    @State var openWeatherView = false
    @State var weatherApiView = false
    let userPoint = CurrentPoint()
    
    var hideButton: Bool { return hideSearchButton || metaDataModel.metaDataObject.isEmpty}
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            //MARK: - Show Map
            MapModel(errorMessage: $errorMessage, searchedResults: $searchedResults, selectedResult: $selectedResult, regionDefault: $regionDefault, directionsOn: $directionsOn, direction: $direction, searchedDistance: $searchedDistance, searchedTime: $searchedTime, destinationLocation: $destinationLocation, searchByCoordinates: $searchByCoordinates)
                .onAppear(perform: locationManager.requestLocation)
                .edgesIgnoringSafeArea(.top)
            
            // MARK: - Search buttons
            if !directionsOn {
                searchRequestButton()
                searchCurrentLocationButton()
                photoObjectButton()
                if isPhotoObjectButtonTapped {
                    searchPhotoObjectByCoordinatesButton()
                }
            }
            
            // MARK: - Button Show/Hide results list
            if  directionsOn || !searchedResults.isEmpty {
                resultsListButton()
            }
            
            // MARK: - Show results and directions
            showMapResultsAndDirections()
            if isSearching {
                ProgressView()
            }
            //MARK: - Show weather from openWeatherMap.org
            if openWeatherView {
                if searchedResults.isEmpty {
                    let coordinate =  userPoint.currentCoordinate
                    weatherInfo(for: coordinate)
                } else {
                    if selectedResult !== MKMapItem(){
                        let coordinate = searchByCoordinates ? destinationLocation : selectedResult.placemark.coordinate
                        weatherInfo(for: coordinate)
                    } else {
                        let coordinate = searchByCoordinates ? destinationLocation : searchedResults.first?.placemark.coordinate
                        weatherInfo(for: coordinate ?? destinationLocation)
                    }
                }
            }
            //MARK: - Show weather from weatherApi.com
            if weatherApiView {
                if searchedResults.isEmpty {
                    let coordinate =  userPoint.currentCoordinate
                    WeatherApiView(coordinates: String(coordinate.latitude) + "," + String(coordinate.longitude), viewingDetails: $weatherApiView).environmentObject(WeatherViewModel())
                } else {
                    if selectedResult !== MKMapItem(){
                        let coordinate = searchByCoordinates ? destinationLocation : selectedResult.placemark.coordinate
                        WeatherApiView(coordinates: String(coordinate.latitude) + "," + String(coordinate.longitude), viewingDetails: $weatherApiView).environmentObject(WeatherViewModel())
                    } else {
                        let coordinate = searchByCoordinates ? destinationLocation : searchedResults.first?.placemark.coordinate
                        WeatherApiView(coordinates: String((coordinate ?? destinationLocation).latitude) + "," + String((coordinate ?? destinationLocation).longitude), viewingDetails: $weatherApiView).environmentObject(WeatherViewModel())
                    }
                }
            }
        }
//MARK: - Manage block
        .navigationModifier(String.mapSearch)
        .toolbar { ToolbarWeather(openWeatherView: $openWeatherView, weatherApiView: $weatherApiView).weatherButtons() }
        .alert(isPresented: $isSearching) {
            Alert(
                title: Text(verbatim: .loading),
                message: nil,
                dismissButton: .cancel(Text(String.cancel))
            )
        }
    }
}
