//
//  LaunchToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.02.2025.
//

import SwiftUI
extension LaunchView {
    var launchToolbar: some View {
        HStack {
            //MARK: - Settings
            Button {
                goSettings.toggle()
            } label: {
                if iPadDevice {
                    HStack {
                        Image(systemName: "gear")
                        Text(String.settings).padding(.trailing, 10)
                        Image(systemName: "shift").font(.footnote)
                        Image(systemName: "command").font(.footnote)
                        Text("P")
                    }
                } else {
                    Image(systemName: "gear")
                }
            }
            .opacity(isPasswordCorrect && !goAutorization ? 1.0 : 0.3)
            .disabled(!isPasswordCorrect || goAutorization)
            .keyboardShortcut("p", modifiers: [.shift, .command])
            .buttonStyle(Hovering(hoverMessage: .profileSettings))
            Spacer()
            
            //MARK: - Localization
            Button {
                switch settings.localeItem {
                case .russian:
                    settings.localeItem = .english
                case .english:
                    settings.localeItem = .russian
                default:
                    settings.localeItem = .russian
                }
            } label: {
                if iPadDevice {
                    HStack {
                        Image(systemName: localeRu ? "e.circle" : "r.circle")
                        Text(localeRu ? String.english : String.russian).padding(.trailing, 10)
                        Image(systemName: "shift").font(.footnote)
                        Image(systemName: "option").font(.footnote)
                        Text("L")
                    }
                } else {
                    Image(systemName: localeRu ? "e.circle" : "r.circle")
                }
            }
            .keyboardShortcut("l", modifiers: [.shift, .option])
            .buttonStyle(Hovering(hoverMessage: .localeItem))
            Spacer()

            //MARK: - Main menu
            Button {
                color = Color.random()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {withAnimation {start = true}})
            } label: {
                if iPadDevice {
                    HStack {
                        Image(systemName: "menubar.dock.rectangle")
                        Text(String.mainMenu).padding(.trailing, 10)
                        Image(systemName: "control").font(.footnote)
                        Text("S")
                    }
                } else {
                    Image(systemName: "menubar.dock.rectangle")
                }
            }
            .opacity(isPasswordCorrect ? 1.0 : 0.3)
            .disabled(!isPasswordCorrect)
            .keyboardShortcut("s", modifiers: [.control])
            .buttonStyle(Hovering(hoverMessage: .mainMenu))
            Spacer()

            //MARK: - New map
            if #available(iOS 17.0, *) {
                Button {
                    color = Color.random()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {withAnimation {startNewMap = true}})
                } label: {
                    if iPadDevice {
                        HStack {
                            Image(systemName: "map")
                            Text(String.newMap).padding(.trailing, 10)
                            Image(systemName: "control").font(.footnote)
                            Text("M")
                        }
                    } else {
                        Image(systemName: "map")
                    }
                }
                .opacity(isPasswordCorrect ? 1.0 : 0.3)
                .disabled(!isPasswordCorrect)
                .keyboardShortcut("m", modifiers: [.control])
                .buttonStyle(Hovering(hoverMessage: .newMap + .withSearchPlaces))
                Spacer()
            }
            
            //MARK: - Autorization
            Button {
                goAutorization.toggle()
            } label: {
                if iPadDevice {
                    HStack {
                        Image(systemName: isPasswordCorrect ? "lock.open" : "key.viewfinder")
                        Text(String.autorization).padding(.trailing, 10)
                        Image(systemName: "shift").font(.footnote)
                        Image(systemName: "command").font(.footnote)
                        Text("A")
                    }
                } else {
                    Image(systemName: isPasswordCorrect ? "lock.open" : "key.viewfinder")
                }
            }
            .opacity(!goSettings ? 1.0 : 0.4)
            .disabled(goSettings)
            .keyboardShortcut("a", modifiers: [.shift, .command])
            .buttonStyle(Hovering(hoverMessage: isPasswordCorrect ? .passAutorization : .tryAutorization))
        }
        .font(.footnote)
        .fontWeight(.semibold)
        .padding(.vertical,  iPadDevice ? 10 : 5)
        .padding(.horizontal,  iPadDevice ? 15 : 5)
        .background(.thinMaterial)
    }
}
