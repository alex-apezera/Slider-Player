//
//  TabViewModels.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.03.2023.
//

import SwiftUI

struct ReceivedView: View {
//    @Environment(\.presentationMode) var presentation
    @State private var isError = false
    @EnvironmentObject var userObject: UserObject


    var body: some View {
        
        ZStack {
            
//            Image(userObject.imagesOfWork[userObject.workIndex])
            
            Color.gray.ignoresSafeArea(edges: .top)

            
            Button("RECEIVED") {
                isError.toggle()
//                tabselected = userObject.workIndex
//                Image(userObject.imagesOfWork[userObject.workIndex])
            }
            .frame(width: 150, height: 40)
            .font(.some(.title))
            .foregroundColor(.white)
            .background(Color.blue)
                            .alert(isPresented: $isError, content: {
                                Alert(title: Text("Show Image?"),
                                      primaryButton: .destructive(
                                        Text("Yes"),
                                        action: {
//                                        TextField("now we tested", text: $text)
                                        }
                                      ),
                                      secondaryButton: .cancel())
                            })
        }
    }
}

struct ReceivedView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedView()
    }
}
