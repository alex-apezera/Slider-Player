//
//  PhotoStackView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.02.2024.
//

//MARK: - Bottom Photo stack row

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct PhotoStackView: View {
    @EnvironmentObject private var metaDataModel: MetaDataModel
    @Binding var selectedPhotoObject: MKMapItem?
    @Binding var locationAddress: String
    @Binding var photoObjectCoordinate: CLLocationCoordinate2D
    @Binding var mediaURL: URL?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(metaDataModel.metaDataObject) { metaData in
                    Button {
                        let latitude = metaData.latitude
                        let longitude = metaData.longitude
                        photoObjectCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        selectedPhotoObject = MKMapItem(placemark: MKPlacemark(coordinate: photoObjectCoordinate))
                        selectedPhotoObject?.name = metaData.placeName
                        locationAddress = metaData.address
                        mediaURL = metaData.url
                    } label: {
                        SelectedFileView(size: 80, url: metaData.url)
                            .allowedDynamicRange(.high)
                    }
                    .buttonStyle(.borderless)
                    .scrollTransition { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                    }
                }
            }
            .frame(maxHeight: 83)
        }
    }
}
