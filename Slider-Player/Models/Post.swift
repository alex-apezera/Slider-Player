//
//  Post.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let ownerUserName: String
    let ownerImage: String
    let caption: String
    let likes: Int
    let image: String
    let timestamp: String
}
