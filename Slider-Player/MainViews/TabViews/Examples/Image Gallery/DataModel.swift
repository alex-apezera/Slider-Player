//
//  DataModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import Foundation

class DataModel: ObservableObject {
    @Published var items: [Item] = []
    
    init() {
        //MARK: - Add an item from WEB
        if let url = URL(string: .imageFromWeb) {
            let item = Item(url: url)
            items.append(item)
        }

        //MARK: - Add items from document directory
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
  
        //MARK: - Add items from Resourses library
        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }
    
    /// Adds an item to the data collection
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    /// Removes an item from the data collection.
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
        }
    }
}
