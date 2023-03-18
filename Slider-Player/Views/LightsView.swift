//
//  LightsView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 09.06.2023.
//

//
//  ContentView.swift
//  Lights
//

import SwiftUI

struct ContentView: View {

//  @AppStorage("lightsOn") private var lightsOn: Bool = false
    
    @State var lightsOn = false

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
    lightsOn ? "Turn the lights off!" : "Turn the lights on!"
  }

  @State private var rotation: Double = 0

  var body: some View {
    ZStack {
      backgroundColor.ignoresSafeArea(.all)
      
      VStack(alignment: .center) {
        Spacer()
        Image(systemName: imageName)
          .font(.system(size: 88))
          .foregroundColor(imageColor)
          .padding()
          .rotationEffect(.degrees(rotation))
          .animation(.easeInOut(duration: 1)) // Deprecated in iOs 15
        Spacer()
        Text(text)
          .font(.largeTitle)
          .bold()
          .animation(.none)
        Toggle("", isOn: $lightsOn.animation())
          .labelsHidden()
      }
      .foregroundColor(foregroundColor)
      .onChange(of: lightsOn, perform: { value in
        if value {
          rotation += 360
        } else {
          rotation -= 360
        }
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
