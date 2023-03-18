//
//  ImageObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.06.2023.
//

import Foundation
import UIKit

class CustomDocument: NSObject, NSCoding  {

    var name : String?
    var image : UIImage?

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "namekey")
        if let imageData = image!.jpegData(compressionQuality: 1.0){
            aCoder.encode(imageData, forKey: "imagekey")
        }
        UserDefaults.standard.synchronize()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let name =  (aDecoder.decodeObject(forKey: "namekey") as? String){
            self.name = name
        }
        if let imageData = (aDecoder.decodeObject(forKey: "imagekey")  as? Data){
            if let image = UIImage(data: imageData){
                self.image = image
            }
        }
    }
}


func archiveDocument(document: CustomDocument) -> Data? {
    do {
        let archivedObject = try NSKeyedArchiver.archivedData(withRootObject: document, requiringSecureCoding: false)
        return archivedObject

    } catch {
        print("Error when try to arhived object")
    }
    return nil
}


func unarchiveDocument(unarchivedObject: Data) -> CustomDocument? {
    do {
        if let document = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject) as? CustomDocument { //Deprecated in iOs 12
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
