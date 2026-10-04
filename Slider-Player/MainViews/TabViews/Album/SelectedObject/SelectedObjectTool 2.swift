//
//  SelectedObjectTool.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.06.2024.
//

import SwiftUI
extension SelectedObjectView {
    
//MARK: - Toolbar for ShowMetaData
    @ToolbarContentBuilder func selectedObjectTool(_ index: Int, item: MetaData) -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            //MARK: - Call Map
            NavigationLink {
                MapView(index: index, hideSearchButton: false).environmentObject(metaDataModel)
            } label: {
                Image(systemName: "map")            ///Show Map Button
            }
            //MARK: - Call export
            ShareLink(
                item: item.url,
                subject: Text(verbatim: .photoFromApp),
                message: Text("\(.date) \(item.date.formatted()), \(.title): \(item.placeName), \(.address): \(item.address)")) {
                Image(systemName: "square.and.arrow.up")
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            Button {
                getLocationData(index)
            } label: {
                Image(systemName: "location.viewfinder")
            }
        }
    }

}
