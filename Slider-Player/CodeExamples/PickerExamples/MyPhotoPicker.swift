//
//  PhotoPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//
/*
 Выбор, загрузка и показ фото на реальном устройстве
 */

import SwiftUI
import PhotosUI
import MapKit

#if canImport(Charts)
@available (iOS 16, *)
struct MyPhotoPicker: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var date: Date?
    @State private var placemarkDate = ""
    @State private var placemarkInfo = ""
    @State private var placemarkLocation: CLLocation? // = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    @State private var placemarkCoordinate: CLLocationCoordinate2D? // = CLLocationCoordinate2D(latitude: 55.7209, longitude: 37.582 )
    
    @State private var enabled = false
    @State private var isPhotoFetched = false
    @State private var isPhotoNotSaved = true
    
    var body: some View {
        
        VStack {
            ScrollView {
                HStack {
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: "photo")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.borderless)
                    
                    if isPhotoFetched {
                        Button {
                            isPhotoNotSaved = true // insert code to save object
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right.circle.fill")
                            //                        .symbolRenderingMode(.multicolor)
                                .font(.system(size: 24))
                                .foregroundColor(isPhotoNotSaved && isPhotoFetched ? .red : .green)
                                .opacity(isPhotoNotSaved && isPhotoFetched ? 0.3 : 1.0)
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: $isPhotoNotSaved) { ContentView() } //
                    }
                }
                
                if let selectedImage {
                    
                        // Here you may insert code  to use avatarImage in other Views
                    
                    if let date = date {
//                        Text("\(date, formatter: DateComponentsFormatter.dateFormat)")
                        Text(dateString(for: date))
                            .padding(8)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(10.0)
                            .foregroundColor(.white)
                            .padding(8)
                    }
                    Text(placemarkInfo)
                        .padding(8)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10.0)
                        .foregroundColor(.white)
                        .padding(8)
                    
                    selectedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .disabled(!enabled)
        }
        .navigationBarTitle("Photolibrary", displayMode: .inline)
        
        //  Извлечение метаданных из фото
        .onChange(of: selectedItem) { newItem in
            if let newItem = newItem, let localID = newItem.itemIdentifier {
                let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                if let asset = result.firstObject {
                    print("\nGOT ASSET: " + asset.debugDescription + "\n")
                    
                    // Получение даты и координат из метаданных
                    DispatchQueue.main.async {
                        
                        if let imageDate = result.firstObject?.creationDate {
                            date = imageDate
                            placemarkDate = dateString(for: date)
                        } else {
                            date = Date()
                            placemarkDate = dateString(for: date)
                        }
                        
                        if let coordinate  = result.firstObject?.location?.coordinate {
                            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            location.placemark { placemark, error in
                                guard let placemark = placemark else {
                                    print("Error: Placemark not defined", error ?? "nil")
                                    placemarkInfo = "Error: Placemark not defined"
                                    return }
                                placemarkInfo = placemark.name ?? ""
                                placemarkInfo += "\n"
                                placemarkInfo += placemark.postalAddressFormatted ?? ""
                                placemarkLocation = location
                                print("TEST: ", placemarkLocation as Any)
                                placemarkCoordinate = coordinate
                                print("TEST: ", placemarkCoordinate as Any)
                            }
                        } else {
                            placemarkInfo = "Placemark not defined"
                        }
                        
                        // Получение изображения фото
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                    isPhotoFetched = true
                                    return
                                }
                            } else {
                                print("Selecting Image is Failed")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                enabled = status == .authorized
            }
        }
    }
}

@available (iOS 16, *)
struct MyPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        MyPhotoPicker()
    }
}
#endif
