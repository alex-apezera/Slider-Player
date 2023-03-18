//
//  ProfileImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.04.2023.
//

// The profile image that reflects the selected item state.
// Работа с изображением Аватара для Профиля Пользователя
// Извлечение фото из Фотобиблиотеки 

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        
        // Состояние загрузки Аватара
        switch imageState {
        case .success(let image):
            // image.resizable() // код без сохранения изображения для следующего сеанса
            
            let renderer = ImageRenderer(content: image)
            // An object that creates images from SwiftUI views.
            
            if let uiImage = renderer.uiImage {
            // The current contents of the view, rasterized as a UIKit image.
                savedImage(uiimage: uiImage).resizable()
            }
        case .loading:
            ProgressView()
        case .retrieve:
            loadedImage().resizable()
        case .empty:
            Image(systemName: "person.fill").font(.system(size: 40)).foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
    
    // Возврат изображения, сохраненного  в UserDefaults
    func savedImage(uiimage: UIImage) -> Image {
        guard let data = uiimage.jpegData(compressionQuality: 0.5) else { return Image("Image Store Error")}
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "userProileImage")
        print(imageState, Image(uiImage: uiimage))
        return Image(uiImage: uiimage)
    }
    
    // Возврат изображения, загруженного из UserDefaults
    func loadedImage() -> Image {
        guard let data = UserDefaults.standard.data(forKey: "userProileImage") else { return Image("Image Retrieve Error") }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let uiimage = (UIImage(data: decoded) ?? UIImage(systemName: "person.fill")!)
        print(imageState, Image(uiImage: uiimage))
        return Image(uiImage: uiimage)
    }
}

// Прорисовка прямоугольника для Аватара
struct RectangleProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Rectangle())
            .frame(width: 130, height: 130)
            .cornerRadius(6)
            .background {
                Rectangle().fill(
                    LinearGradient(
                        colors: [.green, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                ).cornerRadius(6)
            }
    }
}

// Прорисовка круга для Аватара
struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 120, height: 120)
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

// Круглые кнопки для редактирования(выбора)/скрытия(показа) Аватара
// Состояние кнопки скрытия/показа сохраняется при следующем запуске приложения
struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    @ObservedObject var user = UserAutentification()
    @State var profileImageIsEmpty = UserAutentification().profileImageIsEmpty
    
    var body: some View {
        
        CircularProfileImage(imageState: profileImageIsEmpty ? .empty : viewModel.imageState)
            .overlay(alignment: .bottomLeading) {
                Button {
                    viewModel.imageState = profileImageIsEmpty ? viewModel.imageState : .retrieve
                    profileImageIsEmpty.toggle()
                    user.profileImageIsEmpty = profileImageIsEmpty
                } label: {
                    ZStack {
                        if !profileImageIsEmpty {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                                .scaleEffect(profileImageIsEmpty ? 0.0 : 1.0)
                        } else {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                                .scaleEffect(profileImageIsEmpty ? 1.0 : 0.0)
                        }
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
