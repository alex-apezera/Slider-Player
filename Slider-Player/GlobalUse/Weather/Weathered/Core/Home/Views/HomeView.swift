//
//  SearchView.swift
//  Weathered
//
//  First borrowed from christian on 7/26/23.
//

import SwiftUI
import MapKit
import SwiftData

@available(iOS 17.0, *)
struct HomeView: View {
    @EnvironmentObject var weatherVM: WeatherViewModel
    @EnvironmentObject var locationVM: LocationViewModel
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \FavoritePlace.name, order: .forward, animation: .smooth) var favoriteLocations: [FavoritePlace]
    
    @Binding var viewingDetails: Bool
    @Binding var fontDesign: Font.Design
    
    @State var searchText = ""
    
    @State var searchTimer: Timer?
    @State var isSearching = false
    @State var searchResultsNeeded = false
    
    @State var curtainOpacity = 1.0
    
    var locationIsFavorite: Bool {
        favoriteLocations.contains { $0.name == weatherVM.weatherData?.location.name ?? searchText }
    }
    
    func hideResults() {
        searchResultsNeeded = false
    }

    func delete(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favoriteLocations[index])
            }
        }
    }
    
    func updateMap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            locationVM.updateUserLocation()
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Map(position: $locationVM.position)
                    .mapStyle(locationVM.mapStyle)
                    .ignoresSafeArea()
                
                // Gradient Overlay
                LinearGradient(colors: [.sunsetEnd, .sunsetStart], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .opacity(0.85)
                
                // Curtain reveals Map
                Color.black
                    .ignoresSafeArea()
                    .opacity(curtainOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.8)){
                            curtainOpacity = 0.0
                        }
                    }
                
                VStack { // Greeting, Favorite Locations, Search
                    Spacer()
                    if !searchResultsNeeded {
                        GreetingView(fontDesign: fontDesign)

                        Spacer()
                        Spacer()
                        
                        if let currentLocation = locationVM.locationManager.manager.location?.coordinate {
                            let location = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                            
                            CurrentLocationView(currentLocation: location, fontDesign: fontDesign)
                                .padding(.bottom, 20)
                                .offset(y: isSearching ? 1000 : 0)
                        }
                    }
                    
                    favoriteLocationsView // Visible if user has added a favorite location
                    toolBarView // Search and Settings
                }
                
                VStack { // Search Results
                    if weatherVM.weatherData != nil && searchResultsNeeded {
                        HStack {
                            VStack(alignment: .leading) {
                                Spacer()
                                searchResultsView
                                addToFavoritesView
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .offset(y: isSearching ? -80 : 0)
                            .onTapGesture {
                                withAnimation {hideResults()}
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
            }
            .onChange(of: searchText) { _ in
                createQuery()
            }
            .onAppear {
                updateMap()
            }
        }
    }
}
