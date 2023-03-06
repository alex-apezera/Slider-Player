//
//  SecondScreenView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.02.2023.
//

import SwiftUI

struct SecondScreenView: View {
    @Environment(\.presentationMode) var presentation
    @State var showGuidance: Bool = false
    @EnvironmentObject var userObject: UserObject
    @State var selector: String?
    @State var text = ""
    @FocusState var nameIsFocused: Bool
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 10) {
                
                Button("Go back") {
                    self.presentation.wrappedValue.dismiss()
                }
                
                Text(showGuidance == true ?
                     "Hide the info" : "Show the current music work?")
                .font(.headline)
                
                Image(systemName: "info.circle")
                    .font(.title)
                    .opacity(0.3)
                    .onLongPressGesture(minimumDuration: 0.5) {
                        self.showGuidance.toggle()
                    }
                
                Text(showGuidance == true ?
                     "Now we present the image of current work: \(userObject.musicWorks[userObject.workIndex]) work" : "")
                .foregroundColor(.accentColor)
                .background(.clear)
                .font(.body)
                .padding(20)
                .multilineTextAlignment(.center)
                
                Image(showGuidance == true ?
                      userObject.imagesOfWork[userObject.workIndex] : "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                
                
                TextField("Enter Login", text: $text)
                    .myTextModifier()
                    .focused($nameIsFocused)
                TextField("Enter Password", text: $text) { isChanged in
                    print(isChanged)
                } onCommit: { print("onCommit") }
                .myTextModifier()
                
                Button {
                    nameIsFocused = false
//                    hideKeyboard()
                } label: {
                    Text("Login")
                }
                
                Spacer()
                
                NavigationLink(destination: MainTabView(), label: {
                    Text("Go to MainTabView")
                        .font(.title.bold().uppercaseSmallCaps())
                        .frame(width: 350, height: 40, alignment: .center)
                })
            }
        }
    }
}

struct FirstScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreenView()
    }
}
