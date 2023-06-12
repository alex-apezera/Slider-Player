//
//  KeyboardView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.12.2023.
//

import SwiftUI

struct KeyboardView: View {
    let keyboardNum: Int
    @ObservedObject private var pianoKeyboardViewModel = PianoKeyboardViewModel()
    @State private var octaveIndex: Int = 0
    @State private var audioEngine = AudioEngine(octaveNum: 0)
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            Gradient.Stop(color: Color(white: 0.2), location: 0),
                                Gradient.Stop(color: Color(white: 0.3), location: 0.96),
                                Gradient.Stop(color: .black, location: 1),
                            ]), startPoint: .top, endPoint: .bottom)
                    )
                    .shadow(radius: 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 30) {
                        Text("KB \(keyboardNum + 1)")
                        Stepper("Octave: \(octaveIndex)") {
                            octaveIndex += 1
                            audioEngine.octaveNum = octaveIndex
                        } onDecrement: {
                            octaveIndex -= 1
                            audioEngine.octaveNum = octaveIndex
                        }
                        Stepper("Keys: \(pianoKeyboardViewModel.numberOfKeys)") {
                            pianoKeyboardViewModel.numberOfKeys += 1
                        } onDecrement: {
                            pianoKeyboardViewModel.numberOfKeys -= 1
                        }
                        Toggle("Latch:", isOn: $pianoKeyboardViewModel.latch)
                    }
                    .font(.body.bold())
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
            }
            PianoKeyboardView(viewModel: pianoKeyboardViewModel, style: ClassicStyle(sfKeyWidthMultiplier: 0.55))
                .frame(height: 230)
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                .background {
                    Color(.black)
                }
        }
        .ignoresSafeArea()
        .onAppear {
//            pianoKeyboardViewModel.showLabels = true
            pianoKeyboardViewModel.delegate = audioEngine
            audioEngine.start()
            octaveIndex -= keyboardNum
            audioEngine.octaveNum = octaveIndex
        }
    }
}
