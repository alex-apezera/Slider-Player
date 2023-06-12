//
//  PhotoPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//
/*
 
Выбор, загрузка и показ фото на реальном устройстве
+ Архивирование фотообъекта с метаданными для последующего использования


import SwiftUI
import PhotosUI
#if canImport(Charts)

struct MyPhotoPicker: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var enabled = false
    @State private var isPhotoSaved = false
    @State private var isLoading = false
    @State private var isLoaded = false
    @FocusState private var isFocused: Bool
    
    @State var customObject = CustomDocument()
    @State var customObjects = [CustomDocument]()
    @State var imageObject = ImageObject()
    @State var imageObjects = [ImageObject]()
    
    @State private var isImageObjectUpdated = false
    
    func updateImageObject() {
        if let date = customObject.date { imageObject.date = date }
        if let info = customObject.info {imageObject.info = info}
        if let latitude = customObject.latitude {imageObject.latitude = latitude}
        if let longitude = customObject.longitude {imageObject.longitude = longitude}
        if let notes = customObject.notes {imageObject.notes = notes}
        if let uiimage = customObject.image {imageObject.uiimage = uiimage}
        
        imageObjects.insert(imageObject, at: 0)
    }
    
    func getData(newItem: PhotosPickerItem?) {
        isLoading = true
        if let newObject = fetchedObjectFromPicker(from: newItem, to: customObject) {
            let afterTime = DispatchTimeInterval.seconds(1)
            DispatchQueue.main.asyncAfter(deadline: .now() + afterTime, execute: {
                customObject = newObject
                updateImageObject()   ///Добавление в массив (imageObjects) Фотообъекта (imageObject)  из customObject
                isPhotoSaved = true
                isLoading = false
            })
        }
    }
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
                    Spacer()
                    Text("Photolibrary").bold()
                    Spacer()
                    Button {
                        withAnimation {
                            isFocused = false
                            isImageObjectUpdated = true
                            print("IMAGEOBJECTS -->", imageObjects)
                        }
                    } label: {
                        if isLoading {
                            ProgressView()                        ///Show Progress
                        } else {
                            Image(systemName: "arrow.clockwise")  ///Refresh Button
                        }
                    }
                    .padding(10)
                    .disabled(selectedItem == nil)
                }
                .padding(10)
                
                ScrollView {
                    
                    if !isPhotoSaved {
                        Text("Press + for loading").font(.footnote).opacity(0.5)
                    } else {
                        LazyVStack(spacing: 32) {
                            ForEach(0..<imageObjects.count, id:\.self) { indexNumber in
                                VStack {
                                    
                                    Text(dateString(for: imageObjects[indexNumber].date))
                                        .CustomTextModifier()
                                    
                                    TextField("Location information", text: $imageObjects[indexNumber].info, axis: .vertical).lineLimit(7)
                                        .CustomTextModifier()
                                        .keyboardType(.emailAddress)
                                        .focused($isFocused)
                                    
                                    TextField("User notes", text: $imageObjects[indexNumber].notes, axis: .vertical).lineLimit(7)
                                        .CustomTextModifier()
                                        .keyboardType(.emailAddress)
                                        .focused($isFocused)
                                    
                                    Text(coord2String(coordinate: CLLocationCoordinate2D(latitude: imageObjects[indexNumber].latitude, longitude: imageObjects[indexNumber].longitude)))
                                        .CustomTextModifier()
                                    
                                    Image(uiImage: imageObjects[indexNumber].uiimage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                }
            }
            .disabled(!enabled)
        }
        .buttonStyle(.borderless)
        
        //  Извлечение метаданных из объекта фотобиблиотеки в customObject
        .onChange(of: selectedItem) { newItem in
            getData(newItem: newItem)
        }
        // Запрос на извлечение объектов из Фотобиблиотеки
        .onAppear {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                enabled = status == .authorized
            }
        }
    }
}
#endif
*/
