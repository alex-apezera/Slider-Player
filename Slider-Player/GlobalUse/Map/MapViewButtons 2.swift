//
//  MapViewButtons.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.08.2024.
//

import MapKit
import SwiftUI
import CoreLocationUI

extension MapView {
    
//MARK: - Search request button
    func searchRequestButton() -> some View {
        HStack{
            if !searchQuery.isEmpty {
                AnyButton(icon: "xmark.circle") { searchQuery = "" }
                    .font(.system(size: 32))
            }

            TextField("Search...", text: $searchQuery, onEditingChanged: {_ in})
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(7)
                .shadow(radius: 3, x: 0, y: 2)
                .autocorrectionDisabled()

            Button{ withAnimation {
                searchByCoordinates = false
                searchButtonTapped() }
            } label: {
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, isEditing ? 2 : 10)
            }
            .disabled(searchQuery == "" ? true : false)
            .font(.system(size: 32))
            .foregroundColor(.blue)
            .buttonStyle(.borderless)
        }
        .cornerRadius(8)
        .padding(4)
    }
//MARK: - Search current location
    func searchCurrentLocationButton() -> some View {
        LocationButton { withAnimation {
            locationButtonTapped() }
        }
        .labelStyle(.iconOnly)
        .foregroundColor(.white)
        .cornerRadius(50)
        .padding(.top, 70)
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
// MARK: Show Photo object
    func photoObjectButton() -> some View {
        Button(action: photoObjectButtonTapped) {
            if isPhotoObjectButtonTapped {
                photoObjectImage
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 76, height: 76)
            } else {
                Image(systemName: "photo.circle.fill")
            }
        }
        .padding(7)
        .font(.system(size: 40))
        .foregroundColor(hideButton ? .gray : .blue)
        .padding(.leading, 20)
        .padding(.top, 120)
        .frame(width: 50, height: 50)
        .background(Color.clear)
        .padding(7)
        .shadow(radius: 5, x: 0, y: 3)
        .buttonStyle(.borderless)
        .disabled(hideButton)
    }
// MARK: - Photo object location search by coordinates
    func searchPhotoObjectByCoordinatesButton() -> some View {
        Button { withAnimation {
            searchByCoordinatesTapped() }
        } label: {
            Image(systemName: "magnifyingglass.circle")
        }
        .padding(7)
        .font(.system(size: 36))
        .foregroundColor(.indigo)
        .padding(.leading, 20)
        .padding(.top, 250)
        .frame(width: 50, height: 50)
        .background(Color.clear)
        .padding(7)
        .shadow(radius: 4, x: 0, y: 2)
        .buttonStyle(.borderless)
    }
//MARK: - Results list
    func resultsListButton() -> some View {
        Button {
            hideResults.toggle()
        } label: {
            Image(systemName: "plus.rectangle.fill")
        }
        .padding(7)
        .font(.system(size: 32))
        .foregroundColor(hideResults ? .orange : .clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .background(Color.clear)
        .padding(7)
        .buttonStyle(.borderless)
    }
//MARK: - Select location
    func selectLocationButton(_ result: MKMapItem) -> some View {
        Button {
            selectLocation(result: result)
        } label: {
            Image(systemName: "checkmark.circle")
        }
        .font(.system(size: 28))
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .padding()
        .disabled(directionsOn ? true : false)
    }
//MARK: - Hide results list
    func hideResultsListButton() -> some View {
        Button {
            hideResults.toggle()
        } label: {
            Image(systemName: "minus.rectangle")
        }
        .font(.system(size: 28))
        .foregroundColor(.orange)
        .background(Color.clear)
        .padding()
    }
//MARK: Show directions
    func showDirectionsButton(_ result: MKMapItem) -> some View {
        Button {
            directions(result: result)
        } label: {
            Image(systemName: directionsOn ? "eraser.line.dashed.fill" : "road.lanes")
        }
        .font(.system(size: 28))
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .foregroundColor(directionsOn ? .red : .accentColor)
        .padding()
    }
}
