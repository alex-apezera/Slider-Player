//
//  FeedViewModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.03.2023.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() { fetchPosts() }
   
    func fetchPosts() {
        let post1 = Post(ownerUserName: "Alisa", ownerImage: "Alisa", caption: "We like Alisa", likes: 3, image: "Alisa", timestamp: "1 month ago")
        let post2 = Post(ownerUserName: "Elya", ownerImage: "Elya", caption: "We likes Flisa and Elya", likes: 5, image: "Elya", timestamp: "3 month ago in Egipt")
        let post3 = Post(ownerUserName: "Egipt", ownerImage: "Egipt", caption: "We likes travel", likes: 10, image: "Egipt", timestamp: "3 month")
        posts = [post1, post2, post3]
        
    }
    
}
