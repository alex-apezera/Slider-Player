//
//  ImageObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.06.2023.
//
//  Archive/Unarchive CustomObject
//  Fetch custom data from PhotoPicker
/*
import Foundation
import SwiftUI
import PhotosUI

var keyForStore: String = "0"

class CustomDocument: NSObject, NSCoding {

    var date: Date?
    var info: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var notes: String?
    var image: UIImage? = UIImage(systemName: "mappin.slash.circle")
        
    func encode(with aCoder: NSCoder) {

        aCoder.encode(date, forKey: "date\(keyForStore)")
        aCoder.encode(info, forKey: "info\(keyForStore)")
        aCoder.encode(latitude, forKey: "latitude\(keyForStore)")
        aCoder.encode(longitude, forKey: "longitude\(keyForStore)")
        aCoder.encode(notes, forKey: "notes\(keyForStore)")
        if let imageData = image!.jpegData(compressionQuality: 0.3) {
            aCoder.encode(imageData, forKey: "image\(keyForStore)")
        } else { print(#function, "ERROR Unwrapping Image") }
        UserDefaults.standard.synchronize()
        print(#function, keyForStore)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()

        if let date = (aDecoder.decodeObject(forKey: "date\(keyForStore)") as? Date) {
            self.date = date
        }
        if let info =  (aDecoder.decodeObject(forKey: "info\(keyForStore)") as? String) {
            self.info = info
        }
        if let latitude = (aDecoder.decodeObject(forKey: "latitude\(keyForStore)") as? CLLocationDegrees) {
            self.latitude = latitude
        }
        if let longitude = (aDecoder.decodeObject(forKey: "longitude\(keyForStore)") as? CLLocationDegrees) {
            self.longitude = longitude
        }
        if let notes =  (aDecoder.decodeObject(forKey: "notes\(keyForStore)") as? String) {
            self.notes = notes
        }
        if let imageData = (aDecoder.decodeObject(forKey: "image\(keyForStore)")  as? Data){
            if let image = UIImage(data: imageData){
                self.image = image
            }
        }
        print(#function, keyForStore)
    }
}

func archiveDocument(document: CustomDocument) -> Data? {
    do {
        let archivedObject = try NSKeyedArchiver.archivedData(withRootObject: document, requiringSecureCoding: false)
        print("TEST archiveDocument:", archivedObject as Any)
        return archivedObject

    } catch {
        print("Error when try to arhived object")
    }
    return nil
}

func unarchiveDocument(unarchivedData: Data) -> CustomDocument? {
    do {
        if let document = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? CustomDocument {
            //'unarchiveTopLevelObjectWithData' was deprecated in iOS 12.0: Use unarchivedObject(ofClass:from:) instead
        
//        if let document = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, CustomDocument.self], from: unarchivedData) as? CustomDocument {    ///dont work

            print("TEST unArchiveDocument:", document as Any)
            return document
        }
    } catch {
        print("Error when try to unarhived object")
    }
        return nil
}

//Set the object, also you can use an array instead of an object
/*
let obj = CustomDocument()
obj.name = "doc1"
obj.image = UIImage(named: "my_image")
if let archivedObject = archiveDocument(document: obj){
    UserDefaults.standard.set(archivedObject, forKey: "obj")
}
*/

//Get the object
/*
 if let  archivedObject = UserDefaults.standard.data(forKey: "obj"){
 obj = unarchiveDocument(unarchivedObject: archivedObject)
 let myImage = obj?.image
 }
 */


// Очистка памяти, Сохранение и извлечение customObject в/из памяти (UserDefaults)

func updateObject(object: CustomDocument) -> CustomDocument? {
    var updatedObject: CustomDocument = object
    DispatchQueue.main.async {
        
//
        
        if let archivedObject = archiveDocument(document: object){
            UserDefaults.standard.set(archivedObject, forKey: "customObject\(keyForStore)")
        }
        
        if let  archivedObject = UserDefaults.standard.data(forKey: "customObject\(keyForStore)"){
            if let customObject = unarchiveDocument(unarchivedData: archivedObject) {
                updatedObject = customObject
            }
        }
    }
    print(#function, "KEY = customObject\(keyForStore)")
    return updatedObject
}

func removeCustomObject(key: String) {
    UserDefaults.standard.removeObject(forKey: "customObject\(key)")
}

func saveObject(object: CustomDocument, key: String) {
    if let archivedObject = archiveDocument(document: object){
        UserDefaults.standard.set(archivedObject, forKey: "customObject\(key)")
    }
    print(#function, "KEY = customObject\(key)")
}

func reloadObject(object: CustomDocument) -> CustomDocument? {
    var reloadedObject: CustomDocument = object

    DispatchQueue.main.async {
        
        if let  archivedObject = UserDefaults.standard.data(forKey: "customObject\(keyForStore)"){
            if let customObject = unarchiveDocument(unarchivedData: archivedObject) {
                reloadedObject = customObject
            }
        }
    }
    print(#function, "KEY = customObject\(keyForStore)")
    return reloadedObject
}
*/

