//
//  Profile.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.04.2023.

// Авторизация и Создание профиля пользователя

import SwiftUI
import PhotosUI

struct Profile: View {
    var body: some View {
#if os(macOS)
        ProfileForm()
            .labelsHidden()
            .frame(width: 400)
            .padding()
#else
        NavigationView {
            ProfileForm()
        }
#endif
    }
}

struct ProfileForm: View {
    @StateObject var viewModel = ProfileModel()
    @StateObject var user = UserAutentification()
    @State private var password = ""
    @State var frameColor = Color(.systemRed)
    @State private var showAlert: Bool = false
    @State private var isPasswordCorrect: Bool = false
    
    
    var body: some View {
        Form {
            // Аватар Профиля Пользованиеля
            Section {
                HStack {
                    Spacer()
                    EditableCircularProfileImage(viewModel: viewModel)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
        #if !os(macOS)
            .padding([.top], 10)
        #endif
            
            // Авторизация Пользователя
            Section {
                Text("Login")
                TextField("Enter Login", text: $user.userLogin)
                    .myTextModifier()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(frameColor))
                Text("Password")
                TextField("Enter Password", text: $password) { isChanged in
                    if password == "" {frameColor = Color(.systemRed)}
                    frameColor = isChanged ? Color(.systemYellow) : Color(.systemGreen)
                    if !isChanged && user.userPassword != password {
                        showAlert = true
                        frameColor = Color(.systemRed)
                    }
                }
                .myTextModifier()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(frameColor))
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Incorrect password, try again!"))
                }
            }
            
            // Старт Главной программы
            HStack {
                Spacer()
                Button {
                    isPasswordCorrect = user.userPassword == password
                } label: {
                    Image(systemName: "play.circle.fill").font(.system(size: 36)).frame(width: 26, height: 26)
                }
                .opacity(frameColor == Color(.systemGreen) ? 1.0 : 0.3)
                .sheet(isPresented: $isPasswordCorrect) {
                    MainTabView()
                }
                .buttonStyle(GradientButtonStyle())
                Spacer()
            }

            // Ввод данных о пользователе
            // с использованием определителя корректности символов
            Section {
                UserTextField(prompt: "First Name", text: $user.firstName)
                
                UserTextField(prompt: "First Name", text: $user.lastName)
            }
            Section {
                UserTextField(prompt: "About Me", text: $user.aboutMe).lineLimit(10)
            }
        }
        .navigationTitle("Account Profile")
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
