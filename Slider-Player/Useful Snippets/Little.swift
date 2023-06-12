//
//  Little.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.03.2025.
//

//Snippets:

// MARK: - Print MetaDataObject Array<one item>
//print(#function, "indexPath->",  metaDataModel.metaDataObject.map{$0.indexPath}, "id->", metaDataModel.metaDataObject.map{$0.id}, "\n")

//MARK: - Alternate URL for image identifier
//let date = metaData.date
//let timestamp = date.timeIntervalSince1970
//let urlForImage = "\(Int(timestamp)).jpeg"

// MARK: - GetInfo experience
//GetInfo(name: $name, address: $address).convertCoordinateToInfo(locationItem)
//print(#function, "name: ", name, "address: ", address)
//metaData.note = name
//metaData.info = address

//MARK: - Alternate Address + Region
// metaData.info = placemark.postalAddressFormatted ?? ""
// metaData.address += " \(placemark.region ?? "")"

// print(#function, "lastIndex->", metaDataObject.count, "id->", metaDataObject.map{$0.id}, "\n")

//MARK: - Useful Snipset Modifiers
/*
            .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 100, green: 100, blue: 100).opacity(0.7), Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom))

            .clipShape(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
*/
