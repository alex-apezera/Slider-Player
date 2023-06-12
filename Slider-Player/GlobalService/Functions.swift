//
//  Functions.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.12.2023.
//

import SwiftUI
import CoreLocation

//MARK: - Check incorrect characters in text

func notAllowedCharacters(in text: String) -> Int {
    
    let allowedCharacters = " qwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэёячсмитьбю"
    var countOfAllowedCharacters = 0
    
    for character in text {
        if (allowedCharacters + allowedCharacters.uppercased()).contains(character) {
            countOfAllowedCharacters += 1
        }
    }
    return text.count - countOfAllowedCharacters
}

//MARK: - Returns random string (use in generate name of file)
func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

//MARK: - Convert Coordinates to String

func coord2String(coordinate: CLLocationCoordinate2D) -> String {
    return  String(format: "\(String.latitude): %.3f \(String.longitude): %.3f", coordinate.latitude, coordinate.longitude)
}

// MARK: - Save and Load Image /UserDefaults

// Reading the saved image from userDefaults
func getSavedImage(for name: String) -> Image? {
    if let data = UserDefaults.standard.data(forKey: name) {
        if let image = UIImage(data: data) {
            return Image(uiImage: image)
        }
    }
    return nil
}

// Возврат изображения и сохранение его  в UserDefaults
func savedImage(uiimage: UIImage, key: String) -> Image {
    guard let data = uiimage.jpegData(compressionQuality: 0.2) else { return Image(systemName: "questionmark.folder").resizable()}
    let encoded = try! PropertyListEncoder().encode(data)
    UserDefaults.standard.set(encoded, forKey: key)
    return Image(uiImage: uiimage)
}

// Возврат изображения, загружаемого из UserDefaults
func loadedImage(key: String) -> Image {
    guard let data = UserDefaults.standard.data(forKey: key) else { return Image(systemName: "hourglass.start")}
    let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
    let uiimage = (UIImage(data: decoded) ?? UIImage())
    return Image(uiImage: uiimage)
}

//MARK: - Retrieve Audios/FileManager

func getAudios(_ audios: inout [URL]) {
    guard let documentDirectory = documentDirectory else { return }
    do {
        // fetch all data from document directory...
        let urls = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
        
        // updated means remove all old data..
        audios.removeAll()
        
        for url in urls {
            if url.isAudio {
                audios.append(url)
                print(#function, "Success to append Audio:",  url.lastPathComponent)
            }
        }
    } catch {
        print(#function, error.localizedDescription)
    }
}

// MARK: - Images/FileManager

// Path to store Image in FileManager
func fileImageURL(_ fileName: String) -> URL? {
    guard let documentDirectory = documentDirectory else { return nil }
    return documentDirectory.appendingPathComponent("\(fileName).jpeg")
}

// Удаление фотообъекта из FileManager
func removeSelectedObject(fileName: String) {
    guard let url = fileImageURL(fileName) else { return }
    print(#function, url)
    FileManager.default.removeItemFromDocumentDirectory(url: url)
}
func removeSelectedObject(url: URL) {
    print(#function, url)
    FileManager.default.removeItemFromDocumentDirectory(url: url)
}

// Cохранение фотообъекта в FileManager
func saveImageToDocumentDirectory(uiimage: UIImage?, fileName: String) async {
    guard let url = fileImageURL(fileName) else { return }
    await url.saveUIImage(uiimage)
}

// Возврат фотообъекта, загружаемого из FileManager
func loadImageFromDocumentDirectory(fileName: String) -> Image {
    var uiimage = UIImage(systemName: "questionmark.square")
    guard let url = fileImageURL(fileName) else { return Image("AppIcon")}
    url.loadUIImage(&uiimage)
    if let uiimage {
        return Image(uiImage: uiimage)
    } else {
        return Image(systemName: "questionmark")
    }
}
func loadImageFromDocumentDirectory(url: URL) -> Image {
    var uiimage = UIImage(systemName: "questionmark.square")
    url.loadUIImage(&uiimage)
    if let uiimage {
        return Image(uiImage: uiimage)
    } else {
        return Image(systemName: "questionmark")
    }
}
public func imageOnMap(url: URL) -> Image {
    var image = Image(systemName: "questionmark")
    if url.isImage {
        image = loadImageFromDocumentDirectory(url: url)
    } else if url.isVideo {
        if let uiimage =  imageFromVideo(url: url, at: 0) {
            image = Image(uiImage: uiimage)
        }
    }
    return image
}



// MARK: - MetaData/UserDefaults

// Сохранение метаданных в UserDefaults
func saveMetaDataObject(_ metadataObject: [MetaData]) {
    let data = metadataObject.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "metaDataKey")
}

// Загрузка метаданных из UserDefaults
func loadMetaDataObject() -> [MetaData] {
    guard let encodedData = UserDefaults.standard.array(forKey: "metaDataKey") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(MetaData.self, from: $0) }
}

// MARK: - MetaData/FileManager

// Удаление метаданных из FileManager
func removeMetaDataObject() {
    guard let metaURL = metaURL else {return}
    do {
        try FileManager.default.removeItem(at: metaURL)
        print(#function, "Successfully deleted MetaDataObject!", metaURL)
    } catch {
        print(#function, "Error deleting MetaDataObject: \(error)")
    }
}

// Сохранение метаданных в FileManager
func storeMetaDataObject(_ metaDataObject: [MetaData]) {
    guard let metaURL = metaURL else {return}
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(metaDataObject)
        // Save jsonData to a file
        try jsonData.write(to: metaURL)
//        print(#function, "Stored to: ", metaURL)
    } catch {
        print(#function, "Error encoding data: \(error)")
    }
}

// Загрузка метаданных из FileManager
func retrieveMetaDataObject() -> [MetaData] {
    var metaDataObject = [MetaData]()
    guard let metaURL = metaURL else {return []}
    do {
        // Retrieve jsonData from the file using FileManager
        let jsonData = try Data(contentsOf: metaURL)
        let jsonDecoder = JSONDecoder()
        let readingData = try jsonDecoder.decode([MetaData].self, from: jsonData)
// Use the `readingData` array in your app
        metaDataObject = readingData
//        print(#function,  "Retrieved from: ", metaURL)
    } catch {
        print(#function, "Error decoding data: \(error)")
    }
    return metaDataObject
}
