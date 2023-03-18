//
//  AlbumView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.04.2023.
//
/*
 Работа со своим Альбомом фото и видео на реальном устрройстве
 */

import SwiftUI

struct AlbumView: View {
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.mint
                    .opacity(0.15)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading, spacing: 60) {
                        Text("Select objects from Gallery")
                            .font(.system(size: 28, weight: .bold)).foregroundColor(.accentColor)
                        NavigationLink {
                            MoviePicker()
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "video")
                                Text("Movies")
                            }
                        }
                        NavigationLink {
                            MyPhotoPicker()
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "photo")
                                Text("Image")
                            }
                        }
                        NavigationLink {
                            MyPhotosPicker()
                                .navigationViewStyle(.stack)
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "photo.stack")
                                Text("Images")
                            }
                        }
                        NavigationLink {
                            GridView()
                                .environmentObject(dataModel)
                                .navigationViewStyle(.stack)
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "photo.artframe")
                                Text("Images include from App")
                            }
                        }
                        NavigationLink {
                            PHPhotoPickerContentView()
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "mappin.circle")
                                Text("Image with map marker")
                            }
                        }
                    }
                    .font(.system(size: 22))

                }
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
