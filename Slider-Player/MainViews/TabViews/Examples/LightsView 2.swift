//
//  LightsView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.06.2023.
//
//  Lights
// Пример использования @AppStorage

import SwiftUI

struct LightView: View {
        
    @AppStorage("lightsOn") var lightsOn: Bool = false // Store/Retrieve Value for key "lightsOn"
    
    private var backgroundColor: Color {
        lightsOn ? .white : .black
    }
    private var foregroundColor: Color {
        lightsOn ? .black : .white
    }
    private var imageName: String {
        lightsOn ? "sun.max.fill" : "moon.fill"
    }
    private var imageColor: Color {
        lightsOn ? .yellow : .blue
    }
    private var text: String {
        lightsOn ? .turnOff : .turnOn
    }
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            backgroundColor
            
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: imageName)
                    .font(.system(size: 88))
                    .foregroundColor(imageColor)
                    .padding()
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 1), value: rotation)
                Spacer()
                Text(text)
                    .font(.largeTitle)
                    .bold()
                    .animation(.none)
                Toggle("", isOn: $lightsOn.animation()) 
                    .labelsHidden()
                Spacer()                
            }
            .foregroundColor(foregroundColor)
            .onChange(of: lightsOn) { value in
                withAnimation {
                    if value {
                        rotation += 360
                    } else {
                        rotation -= 360
                    }
                }
            }
        }
        .preferredColorScheme(lightsOn ? .light : .dark)
        .navigationBarTitle(String.toggleLights)
        .navigationBarTitleDisplayMode(.inline)
    }
}
