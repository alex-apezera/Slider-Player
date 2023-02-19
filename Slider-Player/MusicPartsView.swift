//
//  MusicPartsView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.02.2023.
//

import SwiftUI

struct MusicPartsView: View {
    @State var segmentIndex: Int = 0
    @State var showGuidance05: Bool = false
    @State var offSetX = 0
    
    var musicWorks = ["anima", "tank", "bones"]
    var imagesOfWork = ["Alisa", "Elya", "Egipt"]
    
    var body: some View {
        VStack {
            Text("Music works   ->   \(musicWorks[segmentIndex].localizedCapitalized)")
                .font(Font.system(.title))
            
            Text(showGuidance05 == true ? "Showing Guidance" : "Not showing")
            
            Image(systemName: "info.circle")
                .opacity(0.3)
                .onLongPressGesture(minimumDuration: 0.5) {
                    self.showGuidance05.toggle()
                }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .padding()
                    .offset(x: CGFloat(offSetX))
                Image(imagesOfWork[segmentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .offset(x: CGFloat(offSetX))
            }.animation(.default)

            Picker(selection: Binding(get: {
                self.segmentIndex
            }, set: { newValue in
                self.segmentIndex = newValue
                self.offSetX = -500
                self.moveBack()
            }), label: Text("")) {
                ForEach(0..<musicWorks.count,  id: \.self) {
                    Text(self.musicWorks[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            Spacer().frame(height: 10)
        }
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.offSetX = 0
        })
    }
}

struct MusicPartsView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPartsView()
    }
}
