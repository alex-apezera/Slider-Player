//
//  SplitView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 15.03.2024.
//
/*

import SwiftUI

struct MyNavigationSplitView: View {
    @State private var selectedLink: Int?
    var body: some View {
        NavigationSplitView {
            List(0..<10, selection: $selectedLink) { number in
                NavigationLink(value: number) {
                    Label(String(number), systemImage: "number")
                }
            }
            .navigationTitle("Numbers")
        } detail: {
            switch selectedLink {
            case .none:
                Text("Nothing selected")
                    .foregroundStyle(.tertiary)
            case .some(let number):
                Text("Number " + String(number) + " selected")
            }
        }
    }
}
*/
