//
//  UserObject.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 25.02.2023.
//

import Foundation

class UserObject: ObservableObject {
    @Published var workIndex = 0
    @Published var musicWorks = ["anima", "tank", "bones"]
    @Published var imagesOfWork = ["Alisa", "Elya", "Egipt"]

//    func musicName() {
//        var index = 0
//        if index >= 0 { return self.musicWorks[Index] }
//        else return 0
//
//    }
}
