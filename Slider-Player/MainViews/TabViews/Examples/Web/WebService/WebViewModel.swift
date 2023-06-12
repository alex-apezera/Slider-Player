//
//  WebViewModel.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 13.06.2025.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var isLoaderVisible = PassthroughSubject<Bool, Never>();
    var webTitle = PassthroughSubject<String, Never>()
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigationAction, Never>()
}
