//
//  Item.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import SwiftUI

struct Item: Identifiable {

    let id = UUID()
    let url: URL

}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
