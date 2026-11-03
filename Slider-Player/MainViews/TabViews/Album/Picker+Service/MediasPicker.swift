//
//  MediasPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//

import SwiftUI
import PhotosUI

/// Get and Manage photo/video Objects
struct MediasPicker: View {
    @State var selectedItems = [PhotosPickerItem]()
    @State var isLoading: Bool = false
    
    @AppStorage("initialColumns") static var initialColumns = 3
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("lastUpdatedObject") var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")
    @AppStorage("tabSelected") var tabSelected = 0
    
    @EnvironmentObject var metaDataModel: MetaDataModel
    
    @State var isEditing = false
    @State var isRemoveAll = false
    
    @Environment(\.displayScale) private var displayScale
    
    static let itemSpacing = 12.0
    static let itemCornerRadius = 15.0
    static let itemSize = CGSize(width: 90, height: 90)
    
    var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: itemSize.width, maximum: itemSize.height), spacing: itemSpacing)
    ]
    
    @State var flexibleColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    
    var columnsTitle: String {
        let count = flexibleColumns.count
        switch count {
        case 1: return "1 \(String.column)"
        case 2...4: return "\(count) \(String.column2s4)"
        case 5...8: return "\(count) \(String.columns)"
        default: return "\(count) \(String.column2s4)"
        }
    }

    let gridMode = UserSettings().gridMode == .gridFlexible
    
    @ViewBuilder
    func selectedObjectView(_ metaData: MetaData) -> some View {
        if metaData.url.isImage {
            GesturedImage(image: loadImageFromDocumentDirectory(url: metaData.url)) }
        else if metaData.url.isVideo { MoviePlay(url: metaData.url)}
        else { EmptyView() }
    }
    
    var body: some View {
        VStack {
            if tabSelected == 1 {
                getNewObjectsIntoAlbum
            } else {
                getNewObjects
            }
        }
        .onChange(of: selectedItems) { _, newItems in ///Get & store data from items
            getAndStoreMetaData(newItems)
        }
    }
}
//#endif


