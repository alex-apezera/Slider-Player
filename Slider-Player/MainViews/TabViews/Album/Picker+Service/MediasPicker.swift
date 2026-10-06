//
//  MediasPicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.04.2023.
//

// MARK: - Get and Manage Image Objects

import SwiftUI
import PhotosUI
//#if canImport(Charts)

struct MediasPicker: View {
    @State var selectedItems = [PhotosPickerItem]()
    @Binding var isLoading: Bool
    @State var selectedItem: PhotosPickerItem?
    
    @AppStorage("initialColumns") static var initialColumns = 3
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("lastUpdatedObject") var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")
    
    @EnvironmentObject var metaDataModel: MetaDataModel
    
    @State var isEditing = false
    @State var isRemoveAll = false
    
    @Environment(\.displayScale) private var displayScale
    
    private static let itemSpacing = 12.0
    private static let itemCornerRadius = 15.0
    private static let itemSize = CGSize(width: 90, height: 90)
    
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: itemSize.width, maximum: itemSize.height), spacing: itemSpacing)
    ]
    
    @State private var flexibleColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    
//    private var columnsTitle: String {
//        flexibleColumns.count > 1 ? "\(flexibleColumns.count) \(String.columns)" : "1 \(String.column)"
//    }
    private var columnsTitle: String {
        let count = flexibleColumns.count
        switch count {
        case 1: return "1 \(String.column)"
        case 2...4: return "\(count) \(String.column2s4)"
        case 5...8: return "\(count) \(String.columns)"
        default: return "\(count) \(String.column2s4)"
        }
    }

    private let gridMode = UserSettings().gridMode == .gridFlexible
    
    @ViewBuilder
    private func selectedObjectView(_ metaData: MetaData) -> some View {
        if metaData.url.isImage {
            GesturedImage(image: loadImageFromDocumentDirectory(url: metaData.url)) }
        else if metaData.url.isVideo { MoviePlay(url: metaData.url)}
        else { EmptyView() }
    }
    
    var body: some View {
        VStack {
            if isEditing && gridMode {
                ColumnStepper(title: columnsTitle, range: 1...8, columns: $flexibleColumns)
                    .padding()
            }
            ScrollView {
                LazyVGrid (columns: gridMode ? flexibleColumns : adaptiveColumns, spacing: Self.itemSpacing) {
                    ForEach(metaDataModel.metaDataObject) { metaData in
                        GeometryReader { geo in
                            NavigationLink {
                                selectedObjectView(metaData)
                            } label: {
                                SelectedFileView(size: gridMode ? geo.size.width : Self.itemSize.width, url: metaData.url)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {removeButton(metaData)}
                    }
                }
                .padding()
            }
        }
        .navigationModifier(String.imagesGallery)
        .navigationViewStyle(.stack)
        .toolbar {toolbarImagePicker()}/// Take data & edit Album
        .onChange(of: selectedItems) { _, newItems in ///Get & store data from items
            getAndStoreMetaData(newItems)
        }
    }
}
//#endif


