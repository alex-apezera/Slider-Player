//
//  SelectedObjectFunc.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.06.2024.

//MARK: - functions for Update and Showing Object

import SwiftUI
import CoreLocation

extension SelectedObjectView {
    
    func updateMetaDataObject(_ metaDataObject: [MetaData]) {
        storeMetaDataObject(metaDataObject)
        metaDataModel.metaDataObject = retrieveMetaDataObject()
    }
    
//MARK: - Get location from Photo object and fetch Meta data
    func getLocationData(_ index: Int) {
        
        var latitude = metaDataModel.metaDataObject[index].latitude
        var longitude = metaDataModel.metaDataObject[index].longitude
        
        let locationNotDefined = latitude == 0 && longitude == 0
        
        let location = locationNotDefined ? userPoint.currentLocation : CLLocation (latitude: latitude, longitude: longitude)
        
        if locationNotDefined {
            latitude = userPoint.currentLatitude
            longitude = userPoint.currentLongitude
            metaDataModel.metaDataObject[index].latitude = latitude
            metaDataModel.metaDataObject[index].longitude = longitude
            storeMetaDataObject(metaDataModel.metaDataObject)
        }
            latitudeText = String(latitude)
            longitudeText = String(longitude)
        
        let getInfo = GetInfo(name: $metaDataModel.metaDataObject[index].placeName, address: $metaDataModel.metaDataObject[index].address)
        getInfo.convertCoordinateToInfo(location)
    }
    
//MARK: - Show Title, Address, Date and Coordinate of Photo object
    func showMetaData(_ index: Int) -> some View {
        VStack(alignment:.center) {
            
            Text(metaDataModel.metaDataObject[index].placeName)
                .font(.title3).bold().foregroundStyle(.primary)
                .onTapGesture {editPlaceName = true}
                        
            Text(metaDataModel.metaDataObject[index].address)
                .font(.footnote).foregroundStyle(.primary).padding(.bottom, 5)
                .onTapGesture {editAddress = true}
                        
            Text(metaDataModel.metaDataObject[index].date.formatted(customDateStyle()))
                .foregroundStyle(.secondary).bold()
            
            HStack {
                Text("\(.latitude): \(latitudeText)")
                    .onTapGesture {editLatitude = true}
                
                Text("\(.longitude): \(longitudeText)")
                    .onTapGesture {editLongitude = true}

                let latitude = metaDataModel.metaDataObject[index].latitude
                let longitude = metaDataModel.metaDataObject[index].longitude
                ElevationView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))

            }
            .foregroundStyle(.tertiary).font(.footnote)
        }
        
//MARK: - Manage block
        .padding(5)
        .multilineTextAlignment(.center)
        .keyboardType(.emailAddress)
        .foregroundStyle(.secondary)
        .onAppear {
            latitudeText = String(metaDataModel.metaDataObject[index].latitude.formatted(.number.precision(.fractionLength(3))))
            longitudeText = String(metaDataModel.metaDataObject[index].longitude.formatted(.number.precision(.fractionLength(3))))
        }
        .onChange(of: latitudeText) { newValue in
            let degree = CLLocationDegrees(Double(newValue) ?? metaDataModel.metaDataObject[index].latitude)
            metaDataModel.metaDataObject[index].latitude = degree
        }
        .onChange(of: longitudeText) { newValue in
            let degree = CLLocationDegrees(Double(newValue) ?? metaDataModel.metaDataObject[index].longitude)
            metaDataModel.metaDataObject[index].longitude = degree
        }
    }
}

