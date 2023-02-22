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
    @State private var isError = false
    @State private var isSharePresented = false
    @State private var segmentIndex: Int = 0
    @State private var offSetX = 0
    private var musicWorks = ["anima", "tank", "bones"]
    private var imagesOfWork = ["Alisa", "Elya", "Egipt"]


    @ObservedObject private var viewModel = PlayerViewModel()

    var body: some View {
        VStack {
            
            Image(systemName: "music.note")
                .imageScale(.large)
                .foregroundColor(.yellow)
                .bold()
            Text("Slider-Player")
                .font(.system(size: 32, weight: .light, design: .default))
            Spacer()
            
//MARK: - Music View
            
            Text(musicWorks[segmentIndex]).font(.largeTitle)
            
            Image(imagesOfWork[segmentIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
                .offset(x: CGFloat(offSetX))
                .animation(.default)
            
            Picker(selection: Binding(get: {
                self.segmentIndex
            }, set: { newValue in
                self.segmentIndex = newValue
                self.offSetX = -500
                self.moveBack()
                print(segmentIndex)

            }), label: Text("")) {
                ForEach(0..<musicWorks.count,  id: \.self) {
                    Text(self.musicWorks[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            Spacer().frame(height: 10)
            
//MARK: - Slider
            
            Slider(value: Binding(
                get: {Double(progress)},
                set: { newValue in
                    print(newValue)
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
            Text("\(Int(progress))")
                .foregroundColor(isEditing ? .red : .blue)
            
 //MARK: - Button PLAY/PAUSE
                        
            HStack{
                Button(isPlaying ? "PAUSE" : "PLAY") {
                    isPlaying.toggle()
                    if isPlaying { viewModel.play(name: musicWorks[segmentIndex])
                        print(musicWorks[segmentIndex])
                    } else { viewModel.stop()
                    }
                }
                .frame(width: 150, height: 50)
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(Color.orange)

//MARK: - ActivityView Button

                Button("SHARE") {
//              isError.toggle() // Alert property not working with .sheet
                    self.isSharePresented = true
                }
                .frame(width: 150, height: 50)
                .font(.some(.largeTitle))
                .foregroundColor(.white)
                .background(Color.blue)
//                .alert(isPresented: $isError, content: {
//                    Alert(title: Text("Show Activity?"),
//                          primaryButton: .destructive(Text("Yes")),
//                          secondaryButton: .cancel())
//                })
                .sheet(isPresented: $isSharePresented) {
                        ActivityView(activityItems: ["message  test"])
                }
            }
        }
        .padding()
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.offSetX = 0
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
