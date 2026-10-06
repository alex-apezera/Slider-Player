//
//  SelectedObjectView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.10.2023.
//

import SwiftUI
import CoreLocation

struct SelectedObjectView: View {
    @State var metaData: MetaData
    @EnvironmentObject var metaDataModel: MetaDataModel
    var userPoint = CurrentPoint()
    @State var latitudeText = "0.0"
    @State var longitudeText = "0.0"
    @State var editPlaceName: Bool = false
    @State var editAddress: Bool = false
    @State var editLatitude: Bool = false
    @State var editLongitude: Bool = false
    
//MARK: - Show Photo Object
    var body: some View {
        if let index = metaDataModel.metaDataObject.firstIndex(where: {$0.id == metaData.id}) {
            ZStack {
                VStack {
                    DetailFileView(url: metaData.url).padding(15)
                    Spacer()
                    showMetaData(index).padding(10)
                }
                //MARK: - Editing meta data
                if editPlaceName {
                    EditText(editText: $editPlaceName, text: $metaDataModel.metaDataObject[index].placeName, title: .title, prompt: .title)
                }
                if editAddress {
                    EditText(editText: $editAddress, text: $metaDataModel.metaDataObject[index].address, title: .address, prompt: .address)
                }
                if editLatitude {
                    EditText(editText: $editLatitude, text: $latitudeText, title: .latitude, prompt: .latitude)
                }
                if editLongitude {
                    EditText(editText: $editLongitude, text: $longitudeText, title: .longitude, prompt: .longitude)
                }
            }
            .toolbar { selectedObjectTool(index, item: metaData) }
            .onChange(of: metaDataModel.metaDataObject) { _, newData in
                updateMetaDataObject(newData)
            }
            .navigationModifier(String.imageCell)
        }
    }
}
