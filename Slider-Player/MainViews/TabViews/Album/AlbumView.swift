//
//  AlbumView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.04.2023.

//MARK: - Album of photo objects

import SwiftUI

struct AlbumView: View {
    @ObservedObject var metaDataModel = MetaDataModel()
    @AppStorage("lastIndex") var lastIndex = 0
    @AppStorage("lastUpdatedObject") var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return .albumTitle
        } else {
            return "\(selection.count) " + .object
        }
    }

    var body: some View {
        List(selection: $selection) {
            ForEach(metaDataModel.metaDataObject) { metaData in
                NavigationLink {
                    SelectedObjectView(metaData: metaData).environmentObject(metaDataModel)
                } label: {
                    imageObjectRow(metaData)
                }
            }
            .onDelete(perform: deleteImageObjects)
            .onMove(perform: moveImageObjects)
        }
        .navigationModifier(title)
        .background(.thinMaterial)
        .toolbar {albumToolbar()}
        .environment(\.editMode, $editMode)
    }
    
//MARK: - Show Image Object Row
    
    func imageObjectRow(_ metaData: MetaData) -> some View {
        HStack {
            SelectedFileView(size: 80, url: metaData.url)
            VStack(alignment: .leading, spacing: 4) {
                Text(dateString(for: metaData.date))
                    .foregroundStyle(.secondary).bold()
                Text(metaData.placeName).bold()
                Text(metaData.address)
            }
            .font(.system(size: 12))
            .lineLimit(5)
            .frame(height: 90)
        }
    }

}
