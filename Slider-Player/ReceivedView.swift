//
//  TabViewModels.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.03.2023.
//

import SwiftUI

struct ReceivedView: View {
    @State private var isError = false

    var body: some View {
        
        NavigationStack {
        
            ZStack {
                
                Color.gray.ignoresSafeArea(edges: .top)
                
                VStack {
                    Button("RECEIVED") {
                        isError.toggle()
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
                                    print("Alert")
                                }
                              ),
                              secondaryButton: .cancel())
                    })
                    
                    NavigationLink {
                        ImageFromURL()
                    } label: {
                        Text("Image")
                    }
                    .frame(width: 150, height: 40)
                    .font(.some(.title))
                    .foregroundColor(.white)
                    .background(Color.blue)
                }
            }
        }
    }
}

struct ReceivedView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedView()
    }
}
