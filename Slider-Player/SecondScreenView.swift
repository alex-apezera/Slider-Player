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
 
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 10) {
                
                Button("Go back") {
                    self.presentation.wrappedValue.dismiss()
                }
                                                
                Text(showGuidance == true ?
                     "Current work: \(userObject.musicWorks[userObject.workIndex])" :
                    "Show the current music work?")
                .font(.title)
                
                Image(systemName: "info.circle")
                    .font(.title)
                    .opacity(0.3)
                    .onLongPressGesture(minimumDuration: 0.5) {
                        self.showGuidance.toggle()
                    }
                Spacer()
                
                NavigationLink(destination: ContentView(), label: {
                    Text("GO TO PLAYER")
                        .font(.largeTitle.bold().uppercaseSmallCaps())
                        .frame(width: 250, height: 40, alignment: .center)
                })
                NavigationLink(destination: ContentView(), tag: "Act1", selection: $selector, label: {
                    Text("Act1")
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
