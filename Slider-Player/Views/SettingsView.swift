//
//  SettingsView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.03.2023.
//
/*
 Пример меню настроек с Пикером и Линком на реальные сайты
 */

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var playerModel = PlayerViewModel()
    @ObservedObject var viewModel = ProfileModel()
    @ObservedObject var user = UserAutentification()
    @State var profileImageIsEmpty = UserAutentification().profileImageIsEmpty
    
//    @State private var isSharePresented = false
    
    private func siteURL() -> String {
        var url = userSettings.nameSites[0]
        if let index = userSettings.nameSites.firstIndex(of: userSettings.nameSite) {
            url = userSettings.guidanceSites[index]
        }
        return url
    }
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                // Секция с меню настроек Профиля
                
                Section(header: Text("PROFILE")) {
                    TextField("Username", text: $userSettings.username)
                    Toggle(isOn: $userSettings.isPrivate) {
                        if !userSettings.isPrivate { Text("Private Account") } else { Text("Private Account is active").foregroundColor(.indigo)
                        }
                    }
                    
                    Picker(selection: $userSettings.ringtone,  label: Text("Rington")) {
                        ForEach(userSettings.ringtones, id: \.self) { ringtone in
                            Text(ringtone)
                                .onAppear(perform: {playerModel.play(name: ringtone)})
                        }
                    }
                    
                    Picker(selection: $userSettings.nameSite, label: Text("Guide")) {
                        ForEach(userSettings.nameSites, id: \.self) { nameSite in
                            Image(systemName: nameSite.lowercased())
                        }
                    }
                    
                    Link(destination: URL(string: siteURL())!) {
                        HStack {
                            Image(systemName: userSettings.nameSite.lowercased())
                                .font(.headline)
                            Text(siteURL())
                        }.scaledToFit()
                    }
                }
                
                // Секция с личным Аккаунтом
                
                if userSettings.isPrivate {
                    Section(header: Text("PRIVATE ACCOUNT")) {
                        HStack {
                            //Avatar
                            RectangleProfileImage(imageState: profileImageIsEmpty ? .empty : ProfileModel().imageState)
                                .overlay(alignment: .bottomLeading) {
                                    Button {
                                        viewModel.imageState = profileImageIsEmpty ? viewModel.imageState : .retrieve
                                        profileImageIsEmpty.toggle()
                                        user.profileImageIsEmpty = profileImageIsEmpty
                                    } label: {
                                        Image(systemName: "arrow.clockwise")
                                            .symbolRenderingMode(.multicolor)
                                            .font(.system(size: 20))
                                            .foregroundColor(profileImageIsEmpty ? .white : .red)
                                            .scaleEffect(profileImageIsEmpty ? 1.0 : 1.0)
                                    }
                                }
                            
                            //TextFields
                            VStack(alignment: .leading, spacing: 1) {
                                Text("First name:\t \(user.firstName)\nLast name:\t \(user.lastName)")
                                Text("")
                                Text("User login:\t \(user.userLogin)")
                                Text("")
                                Text("About me:\t \(user.aboutMe)")
                            }.font(.system(size: 14))
                        }
                    }
                }
            }.navigationTitle("Settings")
            
            // Запасная кнопка для входа в Аккаунт
//            if userSettings.isPrivate {
//                Button("Edit Private Account Profile") {
//                    self.isSharePresented.toggle()
//                }
//                .sheet(isPresented: $isSharePresented) {
//                    Profile()
//                }
//                .buttonStyle(GradientButtonStyle())
//                .padding(.bottom)
//            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
