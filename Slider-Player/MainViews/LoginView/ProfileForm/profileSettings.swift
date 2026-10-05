//
//  profileSettings.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.02.2024.
//
//MARK: - Settings with reference link
/// see UserSettings

import SwiftUI

extension ProfileForm {
    
    //MARK: - Settings menu
    @ViewBuilder var profileSettings: some View {
        
        Text(String.settings).fontWeight(.bold).font(.uppercaseSmallCaps(.title3)()).opacity(0.5)
        
        List {
            
            if userSettings.isPrivate {
                TextField(String.enterMail, text: $userSettings.username)
            }
            Toggle(isOn: $userSettings.isPrivate) {
                if !userSettings.isPrivate { Text(verbatim: .privateAccount) } else { Text(verbatim: .privateAccount + .isActive).foregroundColor(.indigo)
                }
            }
            Picker(selection: $userSettings.ringtone,  label: Text(verbatim: .rington)) {
                ForEach(userSettings.ringtones, id: \.self) { ringtone in
                    Text(ringtone)
                }
                .onChange(of: userSettings.ringtone) { _, ringtone in
                    playerModel.play(name: ringtone)
                }
            }
            Picker(selection: $userSettings.jpegCompression, label: Text(verbatim: .jpegCompression)) {
                ForEach(userSettings.compressionQualities, id: \.self) { number in
                    Text(String(number))
                }
            }
            Picker(selection: $userSettings.pianoKeyboards, label: Text(verbatim: .pianoKeyboards)) {
                ForEach(userSettings.keyboardNums, id: \.self) { number in
                    Text(String(number))
                }
            }
            Picker(selection: $userSettings.pianoKeys, label: Text(verbatim: .pianoKeys)) {
                ForEach(userSettings.keysNumber, id: \.self) { keys in
                    Text(String(keys))
                }
            }
            Picker(selection: $userSettings.initialColumns, label: Text(verbatim: .gridColumns)) {
                ForEach(userSettings.gridColumns, id: \.self) { columns in
                    Text(String(columns))
                }
            }.disabled(userSettings.gridMode == .gridAdaptive)
            
            Picker(selection: $userSettings.gridMode, label: Text(String.gridMode)) {
                ForEach(userSettings.gridModes, id: \.self) { mode in
                    Text(mode)
                }
            }
            Picker(selection: $userSettings.nameSite, label: Text(verbatim: .references)) {
                ForEach(userSettings.guideIcons, id: \.self) { icon in
                    HStack {
                        userSettings.nameSite(for: icon)
                        Image(systemName: icon)
                    }
                }
            }
            Link(destination: URL(string: siteURL)!) {
                HStack {
                    Image(systemName: userSettings.nameSite)
                    Text(siteURL).underline(false)
                }
            }
        }//List
        .cornerRadius(10)
    }
    
    //MARK: - Guidance site url
    var siteURL: String {
        var url = userSettings.guideIcons.first!
        if let index = userSettings.guideIcons.firstIndex(of: userSettings.nameSite) {
            url = userSettings.guideSites[index]
        }
        return url
    }
}
