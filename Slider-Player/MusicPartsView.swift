//
//  MusicPartsView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.02.2023.
//

import SwiftUI

struct MusicPartsView: View {
    @State var showGuidance05: Bool = false
    
//    var musicWorks = ["anima", "tank", "bones"]
//    var imagesOfWork = ["Alisa", "Elya", "Egipt"]
    
    var body: some View {
        VStack {
            
            Text(showGuidance05 == true ? "Showing Guidance" : "Not showing")
            
            Image(systemName: "info.circle")
                .opacity(0.3)
                .onLongPressGesture(minimumDuration: 0.5) {
                    self.showGuidance05.toggle()
                }
            
//            Spacer()
            
            
        }
    }
    
}

struct MusicPartsView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPartsView()
    }
}
