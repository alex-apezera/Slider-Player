//
//  ExamplesView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.05.2023.
//

import SwiftUI

struct ExamplesView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink
                    .opacity(0.15)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading, spacing: 60) {
                        Text("Select useful resource")
                            .font(.system(size: 28, weight: .bold)).foregroundColor(.accentColor)
                        NavigationLink {
                            QRCodeGeneratorView()
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "qrcode")
                                Text("QR Code Generator")
                            }
                        }
                        NavigationLink {
                            BubbleLevel()
                                .environmentObject(MotionDetector(updateInterval: 0.02).started())
                        } label: {
                            HStack(spacing: 50) {
                                Image(systemName: "button.programmable.square")
                                Text("Bubble Level Detector")
                            }
                        }
                    }
                    .font(.system(size: 24))

                }
            }
        }
    }
}

struct ExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesView()
    }
}
