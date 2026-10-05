//
//  ProfileForm.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.03.2025.
//
//MARK: - Profile of user: autorization, profileinfo, settings

import SwiftUI

struct ProfileForm: View {
    @Binding var start: Bool
    @Binding var goAutorization: Bool
    @State var goSettings: Bool

    @StateObject var viewModel = ProfileModel()
    @StateObject var user = UserAutentification()
    @StateObject var userSettings = UserSettings()
    @ObservedObject var playerModel = PlayerModel()
    
    @AppStorage("password") var password = ""
    
    @AppStorage("profileImageIsEmpty") var profileImageIsEmpty: Bool = true

    @State var frameColorLogin = Color(.systemRed)
    @State var showAlert: Bool = false
    @State var showPassword: Bool = false
    @State var editPassword: Bool = false
    @State var startMainTab = false
    @State var editAboutMe: Bool = false
    
    var frameColorPassword: Color { password.isEmpty || password != user.userPassword ? Color(.systemRed) : Color(.systemGreen)}
    var isPasswordCorrect: Bool {
        return password == user.userPassword && !user.userLogin.isEmpty}
    
    @FocusState var isFocused: Bool
        
    var body: some View {
        VStack {
            if goSettings {
                if userSettings.isPrivate { privateInfo }
                profileSettings
            } else {
                autorization
            }
        }
        .font(.callout)
        .padding(10)
        .onChange(of: isPasswordCorrect) { _, newValue in
            withAnimation { start = newValue }
        }
    }
}
