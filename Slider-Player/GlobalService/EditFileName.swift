//
//  EditFileName.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.06.2024.
//

import SwiftUI

struct EditFileName: View {
    let track: URL
    let directory: URL
    @State private var newName: String = ""

//MARK: - Show and edit an audio file name

    var body: some View {
        let name: String = track.deletingPathExtension().lastPathComponent

        TextField(name, text: $newName).font(.callout)
            .onAppear { newName = name }
            .onSubmit {
                let pathExt = track.pathExtension
                do {
                    let destinationPath = directory.appendingPathComponent("\(newName).\(pathExt)")
                    try FileManager.default.moveItem(at: track, to: destinationPath)
                } catch {
                    print(#function, error.localizedDescription)
                }
            }
    }
}
