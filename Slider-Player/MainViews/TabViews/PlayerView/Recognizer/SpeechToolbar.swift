//
//  SpeechToolbar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 17.12.2024.
//
// Navigation toolbar

import SwiftUI

extension SpeechView {
    @ToolbarContentBuilder
    func speechToolbar() -> some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarLeading) {
            
//MARK: - Locale Indicator
            Button {
                print("SpeechView, Locale: \(locale)")
            } label: {
                Image(systemName: localeRu ? "r.square" : "a.square")
            }
            .disabled(true) ///Only for show state of Locale case

//MARK: - Clear all messages
            Button {
                withAnimation {
                    isRemoveAllMessages = true
                }
            } label: {
                Image(systemName: "trash")
            }
            .actionSheet(isPresented: $isRemoveAllMessages) {
                ActionSheet(
                    title: Text(String.actionText),
                    message: Text(String.actionMessage),
                    buttons:[
                        .destructive(Text(String.actionOK), action: removeAllMessages),
                        .cancel(Text(String.cancel))
                    ]
                )
            }
            .disabled(isRecording || messages.isEmpty)
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            
//MARK: - Export Message
            ShareLink(item: message, subject: Text(String.app), message: Text(String.speechRecognizer), preview: SharePreview(String.speechRecognizer, image: Image(systemName: "square.and.arrow.up")))
                .disabled(isRecording || message.isEmpty)
            
//MARK: - On/Off  Recognizer Button
            Button {
                withAnimation {isRecording.toggle()}
                speechAction()
            } label: {
                if isRecording {
                    Image(systemName: "mic.square.fill")
                        .blinking()
                } else {
                    Image(systemName: "mic")
                }
            }
            .foregroundColor(isRecording ? .yellow : .accentColor)
        }
    }
}

