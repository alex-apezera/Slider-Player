//
//  CapturedPhotoView.swift
//  Little-things
//
//  Created by Алексей Езерский on 29.12.2024.
//

import SwiftUI

struct CapturedPhotoView: View {
    @EnvironmentObject var metaDataModel: MetaDataModel
    @State private var image: Image?
    @AppStorage("saveToPhotoLibrary") var saveToPhotoLibrary = false
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("lastUpdatedObject") var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    @State var showMessage: Bool = false
    
    var title: String {
        return saveToPhotoLibrary ? .captureAndSave : .capture
    }

    var body: some View {
        VStack(alignment: .leading) {
            CameraPicker() { uiimage in
                let id = randomString(length: idLength)
                if let fileURL = FileManager.default.createFileInDirectory(name: id) {
                    let item = MetaData(id: id, date: Date(), address: "", placeName: "", latitude: 0, longitude: 0, url: fileURL)
                    if let data = uiimage.jpegData(compressionQuality: UserSettings().jpegCompression) {
                        try? data.write(to: fileURL)
                        withAnimation {
                            metaDataModel.metaDataObject.insert(item, at: 0)
                        }
                        storeMetaDataObject(metaDataModel.metaDataObject)
                        lastIndex = metaDataModel.metaDataObject.count
                        lastUpdatedObject = Date().timeIntervalSince1970
                    }
                }
                image = Image(uiImage: uiimage)
                if saveToPhotoLibrary {
                    let imageSaver = PhotoSaver()
                    imageSaver.writeToPhotoAlbum(image: uiimage)
                }
            }
        }
        .overlay { /// popover message
            if showMessage {
                Message(message: saveToPhotoLibrary ? .saveToLibrary : .cancelToSave)
            }
        }
        .navigationModifier(title)
        .toolbar {savePhotoToLibraryIcon()}
    }
}
