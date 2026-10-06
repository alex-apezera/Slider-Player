//
//  SearchView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.08.2024.
//
//  Search track from iTunes.com + List + Mini player

import SwiftUI
import AVKit

struct SearchView: View {
    @State var results = [Result]()
    @AppStorage("searchRequest") var searchRequest = "Taylor+Swift"
    @State var playContent = false
    @State var result: Result?
    @State var track = URL(fileURLWithPath: "")
    @AppStorage("iTunesCount") var resultsCount: Int = 0

    var body: some View {
        VStack {
            
//MARK: - Search request
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(String.searchRequest, text: $searchRequest)
                if !searchRequest.isEmpty {
                    AnyButton(icon: "xmark.circle") { searchRequest = "" }
                }
            }
            .customTextModifier
            .padding()
                        
//MARK: - Play/stop selected result
            if playContent {
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        Button {
                            playContent = false
                        } label: {
                            AsyncImage(url: result?.artworkUrl100) { image in
                                image.resizable()
                                    .cornerRadius(10)
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .frame(width: 150, height: 150)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(result?.collectionName ?? "").font(iPadDevice ? .body : .callout)
                            Text(result?.trackName ?? "").font(iPadDevice ? .callout : .footnote)
                            Text(result?.artistName ?? "").font(.footnote)
                        }
                    }///end HStack
                    MoviePlay(url: track)                       .cornerRadius(10)
                }///end VStack
                .padding(.leading, 15).padding(.trailing, 15)
            }/// end if

//MARK: - List searched results
            VStack {
                List(results, id: \.trackId) { item in
                    HStack {
                        Button {
                            playContent = true
                            track = item.previewUrl
                            result = item
                        } label: {
                            AsyncImage(url: item.artworkUrl60) { image in
                                image.cornerRadius(10)
                            } placeholder: {
                                ProgressView().frame(width: 60, height: 60)
                            }
                        }
                        VStack(alignment: .leading, spacing: 3) {
                            Text(item.collectionName).font(iPadDevice ? .body : .footnote).fontWeight(.medium)
                            Text(item.trackName).font(.footnote)
                        }
                    }///end HStack
                }/// end List
            }/// end VStack
            
//MARK: - Load searched results
            .task {
                await loadData()
            }
            .onChange(of: searchRequest) {
                Task {
                    playContent = false
                    await loadData()
                }
            }
        }/// end starting VStack
        .navigationModifier(String.itunesList + ": " + String(resultsCount))
    }///end body
}///end SearchView
 
