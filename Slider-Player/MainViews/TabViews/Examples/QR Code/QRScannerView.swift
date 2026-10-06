//
//  QRScannerView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 10.06.2025.
//

import SwiftUI

struct QRScannerView: View {
    @Binding var scanUrl: String
    
    @State var scanResult = String.qrCodeNotRecognized
    @State var webState: WebType = .awaitToScan
    enum WebType {
        case urlLoaded, awaitToScan
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            if webState == .awaitToScan {
                QRScanner(result: $scanResult)
                    .onChange(of: scanResult) { _, newValue in
                        scanUrl = newValue
                        withAnimation {webState = .urlLoaded}
                    }
                Text(scanResult)
                    .padding()
                    .background(.thickMaterial)
                    .foregroundColor(.primary)
                    .background(.gray, in: .rect(cornerRadius: 5).stroke(style: .init(lineWidth: 1)))
                    .cornerRadius(5)
                    .padding(.bottom)
            } else if webState == .urlLoaded {
                WebContentView(webUrl: scanUrl)
                    .onDisappear {withAnimation {webState = .awaitToScan}}
            }
        }
        .navigationModifier(.qrCodeScanner)
    }
}
