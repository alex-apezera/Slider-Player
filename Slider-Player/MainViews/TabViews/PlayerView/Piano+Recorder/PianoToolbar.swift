//
//  PianoToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.06.2024.
//

import SwiftUI
extension PianoKeyboard {
    @ToolbarContentBuilder
    func pianoToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
//MARK: - Playing audio
            if playing && !isAudioFinished {   /// Turn Off Player if necessary
                Button {
                    audioManager.stop()
                    playing = false
                } label: {
                    Image(systemName: "speaker.wave.2")
                        .blinking()
                        .foregroundStyle(Color(.orange))
                }
            }
//MARK: - Recorder (silent piano playing on iPhone)
                Button {
                    recordAndStoreAudio(record: &record, recorder: &recorder, audios: &audios)
                } label: {              ///On/Off  Microphone Button
                    if record {
                        Image(systemName: "mic.square.fill")
                            .blinking()
                    } else {
                        Image(systemName: "mic")
                    }
                }
                .foregroundColor(record ? .yellow : .accentColor)
        }
    }
}
