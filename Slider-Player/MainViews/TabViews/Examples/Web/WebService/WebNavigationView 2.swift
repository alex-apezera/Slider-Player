//
//  WebNavigationView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 13.06.2025.
//

import SwiftUI

struct WebNavigationView: View {
    @ObservedObject var viewModel: WebViewModel
    @State var webTitle = ""

    let fontSize: CGFloat = 20///default 30
    let frameSize: CGFloat = 30 ///default 50
    let horizontalSpacing: CGFloat = 10 ///default 10
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: horizontalSpacing) {
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.backward)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: fontSize, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.forward)
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: fontSize, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
                Text(webTitle).onReceive(viewModel.webTitle.receive(on: RunLoop.main)) { value in
                    webTitle = value
                    print("TITLE", value)
                }
                Spacer()
                Divider()
                Button(action: {
                    viewModel.webViewNavigationPublisher.send(.reload)
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: fontSize, weight: .regular))
                        .imageScale(.medium)
                })
                Divider()
            }
            .frame(height: frameSize)
            Divider()
        }
    }
}

#Preview {
    WebNavigationView(viewModel: WebViewModel())
}
