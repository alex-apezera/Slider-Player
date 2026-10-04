//
//  SpeechFunc.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.12.2024.
//
// Recognizer functions

import SwiftUI

extension SpeechView {
    
    func speechAction() {
        if isRecording {
            speechRecognizer.reset()
            speechRecognizer.transcript = ""
            speechRecognizer.transcribe()
        } else {
            speechRecognizer.stopTranscribing()
            message += message.isEmpty ? speechRecognizer.transcript : " " + speechRecognizer.transcript
            lastUpdatedSpeech = Date().timeIntervalSince1970
        }
    }
    
    func removeAllMessages() {
        messages.removeAll()
    }
    
    func removeMessage(at item: SpeechItem) {
        if let index = messages.firstIndex(where: {$0.id == item.id}) {
            messages.remove(at: index)
        }
    }
    
    func copyMessageButton(of item: SpeechItem) -> some View {
        Button {
            message = item.message
        } label: {
            Image(systemName: "arrow.up.message")
                .font(.title3)
                .opacity(0.4)
        }
    }
    
    func removeMessageButton(of item: SpeechItem) -> some View {
        Button {
            removeMessage(at: item)
        } label: {
            Image(systemName: "xmark.circle")
                .font(.title3)
                .foregroundStyle(.red)
                .opacity(0.4)
        }
    }
    
    func sendMessageButton() -> some View {
        Button {
            let dateTimeStamp = Date.now.formatted()
            withAnimation {
                messages.insert(SpeechItem(message: message, date: dateTimeStamp), at: 0)
            }
            message = ""
        } label: {
            Image(systemName: "arrow.down.message").font(.title3)
        }
        .disabled(isRecording || message.isEmpty)
    }
}
