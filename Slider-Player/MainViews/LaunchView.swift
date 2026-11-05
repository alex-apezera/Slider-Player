//
//  LaunchView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 22.12.2023.
//

import SwiftUI

/// Launch screen with menu. See README.MD.
struct LaunchView: View {
    @Binding var start: Bool

    @StateObject var settings = UserSettings()
    @StateObject var user = UserAutentification()
    @State var color = Color(red: 10/255, green: 90/255, blue: 230/255)
    @State var goAutorization = false
    @State var goSettings = false
    @State var startApp = false
    
    @AppStorage("password") var password = ""
    
    var isPasswordCorrect: Bool {
        return password == user.userPassword && !user.userLogin.isEmpty}

    var body: some View {
        if !iPadDevice {
            Text(String.homePage).bold()
        }
        ZStack {
            color.opacity(0.3)
            VStack {
                launchToolbar
                ZStack {
                    ScrollView {
                        Text(verbatim: localeRu ? .readmeRu : .readmeEn)
                            .padding()
                    }
                    if goAutorization || goSettings {
                        Profile(start: $startApp, goAutorization: $goAutorization, goSettings: goSettings)
                    }
                }
                .padding()
            }
        }
        .font(.body)
        .titleInline(String.homePage)
        .edgesIgnoringSafeArea(.bottom)
    }
}
