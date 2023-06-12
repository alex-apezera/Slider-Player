//
//  ProfileImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.04.2023.
//
//MARK: - Pick Avatar from Photolibrary
/// The profile image that reflects the selected item state.

import SwiftUI
import PhotosUI

//MARK: - Avatar load state
struct ProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        
        switch imageState {
        case .success(let image):
            
            let renderer = ImageRenderer(content: image)
            /// An object that creates images from SwiftUI views.
            
            if let uiImage = renderer.uiImage {
            /// The current contents of the view, rasterized as a UIKit image.
                savedImage(uiimage: uiImage, key: "userProfileImage").resizable() /// save to UserDefaults
            }
        case .loading:
            ProgressView()
        case .retrieve:
            loadedImage(key: "userProfileImage").resizable() /// get from UserDefaults
        case .empty:
            Image(systemName: "person.fill").font(.system(size: 40)).foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

//MARK: - Avatar
struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState
    @State private var selected: Bool = false
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: selected ? 200 : 120, height: selected ? 330 : 120)
            .shadow(radius: selected ? 12 : 8)
            .animation(.smooth, value: selected)
            .scaleEffect(selected ? 1.3 : 1.0)
            .animation(.bouncy, value: selected)
            .onTapGesture {
                selected.toggle()
            }
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.pink, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

// MARK: - Avatar: manage at loading
struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    @AppStorage("profileImageIsEmpty") var profileImageIsEmpty: Bool = true
    
    var body: some View {
        CircularProfileImage(imageState: profileImageIsEmpty ? .empty : viewModel.imageState)
            .overlay(alignment: .bottomLeading) {
                Button {
                    viewModel.imageState = profileImageIsEmpty ? viewModel.imageState : .retrieve
                    profileImageIsEmpty.toggle()
                } label: {
                    Image(systemName: profileImageIsEmpty ? "person.crop.circle.badge.plus" : "person.crop.circle.badge.minus" )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                }
            }
            .buttonStyle(.borderless)
            .symbolRenderingMode(.multicolor)
            .font(.system(size: 30))
            .foregroundColor(.accentColor)
    }
}
