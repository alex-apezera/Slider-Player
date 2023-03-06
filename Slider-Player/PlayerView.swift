//
//  PlayerView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.02.2023.
//

import SwiftUI

struct PlayerView: View {
    @State private var progress: Float = 0
    @State private var isPlaying: Bool = false
    @State private var isEditing: Bool = false
    @State private var isSharePresented = false
    @State private var offSetX = 0
    @State private var segmentIndex: Int = 0
    
    @ObservedObject private var userObject = UserObject()
    
    @ObservedObject private var playerModel = PlayerViewModel()
    
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.offSetX = 0
        })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "music.note")
                        .imageScale(.large)
                        .foregroundColor(.yellow)
                        .bold()
                    
                    Text(" ->   \(userObject.musicWorks[segmentIndex])")
                        .font(.system(size: 24, weight: .light, design: .default))
                }
                
                NavigationLink {
                    AccountView()
                } label: {
                    Text("Press here to AccountView")
                }
                
                //MARK: - Music View
                
                Image(userObject.imagesOfWork[segmentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .offset(x: CGFloat(offSetX))
                    .animation(Animation.easeInOut(duration: 1.0), value: offSetX)

                Picker(selection: Binding(
                    get: {segmentIndex},
                    set: { newValue in
                        segmentIndex = newValue
                        userObject.workIndex = segmentIndex
                        offSetX = -500
                        moveBack()
                        print(userObject.workIndex)
                        if progress > 0 {
                            isPlaying = false
                            progress = 0
                            playerModel.stop()
                        }
                    }), label: Text("")) {
                        ForEach(0..<userObject.musicWorks.count,  id: \.self) {
                            Text(self.userObject.musicWorks[$0]).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                Spacer().frame(height: 0)
                
                //MARK: - Slider
                
                Slider(value: Binding(
                    get: {Double(progress)},
                    set: { newValue in
                        print(newValue)
                        progress = Float(newValue)
                        playerModel.setTime(value: progress)
                        if isPlaying {
                            playerModel.stop()
                            //                        isPlaying.toggle()
                        }
                    }),
                       in: 0...playerModel.maxDuration
                ) {
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text(String(Int(playerModel.maxDuration)))
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                Text("\(Int(progress))")
                    .foregroundColor(isEditing ? .red : .blue)
                
                
                //MARK: - Button PLAY/PAUSE
                
                HStack{
                    Button(isPlaying ? "PAUSE" : "PLAY") {
                        isPlaying.toggle()
                        if progress > 0 {
                            progress = 0
                            isPlaying = false
                            playerModel.stop()
                        }
                        if isPlaying { playerModel.play(name: userObject.musicWorks[segmentIndex])
                        } else { playerModel.stop()
                        }
                    }
                    .frame(width: 130, height: 40)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    
                    //MARK: - ActivityView Button
                    
                    Button("SHARE") {
                        self.isSharePresented = true
                    }
                    .frame(width: 130, height: 40)
                    .font(.some(.title))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .sheet(isPresented: $isSharePresented) {
                        ActivityView(activityItems: ["message  test"])
                    }
                }
            }
            .padding()
        }
        .environmentObject(userObject)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
