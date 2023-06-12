//
//  Slider_PlayerTests.swift
//  Slider-PlayerTests
//
//  Created by Алексей Езерский on 09.05.2025.
//

import Testing
import SwiftUI

@testable import Slider_Player

struct Slider_PlayerTests {
    
    @StateObject var viewModel: NewsViewModel = .init()

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
//        #expect(Slider_Player.text == "Hello, World!")
    }
    @Test func performanceExample() async throws {
        self.viewModel.fetchTopNews()
//        var measure: TimeInterval = 0
        for _ in 0..<10 {
            _ = DispatchTime.now()
            self.viewModel.fetchTopNews()
            _ = DispatchTime.now()
        }
    }

}

extension Tag {
    @Tag static var formatting: Tag
}

struct DateTests {
    @Test(.tags(.formatting)) func firstFrame() {
        // ...
    }
    
    @Test func dateString() {
        #expect(Slider_Player.dateString(for: Date()) != "" )
    }
}

