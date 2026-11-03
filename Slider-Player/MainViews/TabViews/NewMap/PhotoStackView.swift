//
//  PhotoStackView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.02.2024.
//

//MARK: - Bottom Photo stack row

import SwiftUI
import MapKit

struct PhotoStackView: View {
    @EnvironmentObject private var metaDataModel: MetaDataModel
    @Binding var selectedPhotoObject: MKMapItem?
    @Binding var locationAddress: String
    @Binding var photoObjectCoordinate: CLLocationCoordinate2D
    @Binding var mediaURL: URL?
    
    @State private var selectedItem: MetaData?

    fileprivate func prepareMapAnnotation(_ metaData: MetaData) {
        let latitude = metaData.latitude
        let longitude = metaData.longitude
        photoObjectCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = CLLocation(latitude:  photoObjectCoordinate.latitude, longitude: photoObjectCoordinate.longitude)
        selectedPhotoObject = MKMapItem(location: location, address: nil)
        
        selectedPhotoObject?.name = metaData.placeName
        locationAddress = metaData.address
        mediaURL = metaData.url
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(metaDataModel.metaDataObject) { metaData in
                    SelectedFileView(size: 80, url: metaData.url)
                        .onTapGesture { prepareMapAnnotation(metaData) }
                        .onLongPressGesture(minimumDuration: 0.5) {
                            selectedItem = metaData
                        }
                        .allowedDynamicRange(.high)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                .opacity(phase.isIdentity ? 1.0 : 0.0)
                        }/// Уменьшает концевики при скроллинге
                }
            }
            .frame(maxHeight: 83)
        }
        .sheet(item: $selectedItem) { item in
            SelectedObjectView(metaData: item)
                .environmentObject(metaDataModel)
        }
    }
}
