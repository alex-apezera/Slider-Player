//
//  WebContentView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 12.06.2025.
//
//  Github: Created by Ivan Telenkov on 30.03.2021.
//  proglibWebView/WebView.swift

import SwiftUI

struct WebContentView: View {
    let webUrl: String
    
    @StateObject var viewModel = WebViewModel()
    @State var isLoaderVisible = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                WebNavigationView(viewModel: viewModel)
                WebView(type: .public, url: webUrl, viewModel: viewModel)
//                WebView(type: .local, url: "local", viewModel: viewModel)
            }
            if isLoaderVisible {
                LoaderView()
            }
        }
        .onReceive(viewModel.isLoaderVisible.receive(on: RunLoop.main)) { value in
            isLoaderVisible = value
        }
        .navigationModifier(webUrl)
    }
}

#Preview {
    WebContentView(webUrl: .webUrlExample)
}
