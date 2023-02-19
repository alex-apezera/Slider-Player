//
//  ContentView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Float = 0
    @State private var isPlaying: Bool = false
    @State private var isEditing: Bool = false
    @ObservedObject private var viewModel = PlayerViewModel()
    @State var isError = false
    
    var body: some View {
        VStack {
            
            Image(systemName: "music.note")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .bold()
            Text("Slider-Player")
                .font(.system(size: 24, weight: .light, design: .default))
            Spacer()
            
            Slider(value: Binding(
                get: {Double(progress)},
                set: { newValue in
                   progress = Float(newValue)
                   viewModel.setTime(value: progress)
                }),
                   in: 0...viewModel.maxDuration
            ) {
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text(String(Int(viewModel.maxDuration)))
            } onEditingChanged: { editing in
                isEditing = editing
            }
//            progress = viewModel.player?.currentTime
            Text("\(Int(progress))")
                .foregroundColor(isEditing ? .red : .blue)
        
                        
            HStack{
                Button(isPlaying ? "PAUSE" : "PLAY") {
                    isPlaying.toggle()
                    if isPlaying { viewModel.play() }
                    else if isPlaying && isEditing {
                        viewModel.setTime(value: progress) }
                    else { viewModel.stop() }
                }
                .frame(width: 150, height: 50)
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(Color.orange)
                
                Button("Progress View") {
                    isError.toggle()
                }
                .frame(width: 150, height: 50)
                .font(.some(.headline))
                .foregroundColor(.white)
                .background(Color.blue)
                .alert(isPresented: $isError, content: {
                    Alert(title: Text("Show ProgressView?"), primaryButton: .destructive(Text("Yes"), action: {
                       
                    }), secondaryButton: .cancel())
                })
            }
            Spacer()
//            ProgressView(value: progress)
//            Spacer()
        }
        .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
