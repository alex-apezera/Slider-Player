//
//  PhotoPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    // Изменяемые (вычисляемые в данной структуре) переменные для передачи в вызывающую структуру
    @Binding var date: Date?
    @Binding var location: CLLocationCoordinate2D

    @EnvironmentObject var dataModel: DataModel
    
    /// A dismiss action provided by the environment. This may be called to dismiss this view controller.
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    /// Creates the picker view controller that this object represents.
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        
        // Configure the picker.
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        // Limit to images.
        configuration.filter = .images
        // Avoid transcoding, if possible.
        configuration.preferredAssetRepresentationMode = .current
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    /// Creates the coordinator that allows the picker to communicate back to this object.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// Updates the picker while it’s being presented.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
        // No updates are necessary.
    }
    //}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        /// Called when one or more items have been picked, or when the picker has been canceled.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // Dismisss the presented picker.
            self.parent.dismiss()
//            parent.presentationMode.wrappedValue.dismiss()
            
            guard
                let result = results.first,
                result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
            else { return }
            
            // MARK: Fetch (and copy) Image Url from picked item
            
            // Load a file representation of the picked item.
            // This creates a temporary file which is then copied to the app’s document directory for persistent storage.
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                if let error = error {
                    print("Error loading file representation: \(error.localizedDescription)")
                } else if let url = url {
                    if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url) {
                        // Add the new item to the data model.
                        Task { @MainActor [dataModel = self.parent.dataModel] in
                            withAnimation {
                                let item = Item(url: savedUrl)
                                dataModel.addItem(item)
                                print("ITEM = ", item, "\n RESULT = ", result)
                            }
                        }
                    }
                }
            }
            
            //MARK: Fetch Assets (date+coordinate) from picked item
            
            if let assetId = result.assetIdentifier {
                let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                DispatchQueue.main.async {
                    if let imageDate = assetResults.firstObject?.creationDate {
                        self.parent.date = imageDate
                        print("imageDate = ", imageDate)
                    } else {
                        print("imageDate = NOT DEFINED")
                        return }
                    if let coordinate  = assetResults.firstObject?.location?.coordinate {
                        self.parent.location = coordinate
                        print("coordinates = ", coordinate)
                        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        location.placemark { placemark, error in
                            guard let placemark = placemark else {
                                print("Error: Placemark not defined", error ?? "nil")
                                return }
                            print(placemark.postalAddressFormatted ?? "") // Post Address
                            print(placemark.name ?? "")
                        }
                        //                    location.fetchCityAndCountry { city, country, error in
                        //                        guard let city = city, let country = country, error == nil else { return }
                        //                        print("City and Country: ", city + ", " + country)  // fetch Exif Data from current Image location (City & Country)
                        //                    }
                    } else {
                        print("coordinates = NOT DEFINED")
                        return }
                }
            }
        }
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
    }
}
