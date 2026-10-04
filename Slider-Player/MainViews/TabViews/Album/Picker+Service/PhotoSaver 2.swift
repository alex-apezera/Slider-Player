//
//  PhotoSaver.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 05.01.2025.
//
///Как сохранить изображения в библиотеке фотографий пользователя
///Пол Хадсон @twostraws 11 декабря 2023 года (hackingwithswift.com)

import SwiftUI

class PhotoSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            print(#function, error)
        } else {
            print(#function, "Save captured foto to Photo Library finished!")
        }

       
    }
}
