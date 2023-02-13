//
//  ContentView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.02.2023.
//

import SwiftUI
import AVFoundation

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?
    
    public func play() {
        playSong(name: "anima")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else {return}
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView: View {
    @State private var progress: Float = 0
    @State private var isEditing: Bool = false
    @ObservedObject var viewModel = PlayerViewModel()
    
    
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
                get: {Double(self.progress)},
                set: { newValue in
                    self.progress = Float(newValue)
                    self.viewModel.setTime(value: Float(newValue))
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
                Button("PLAY") {
                    self.viewModel.play()
                }
                .frame(width: 100, height: 50)
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(Color.orange)
        
                Button("STOP") {
                    self.viewModel.stop()
                }
                .frame(width: 100, height: 50)
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(Color.orange)
            } .padding(40)
            
            Spacer()
        
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
