//
//  SpeechView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.12.2023.
//
// Recognizer view

//MARK: - Processing Speech to text Notes

import SwiftUI

struct SpeechView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var isRecording = false
    @State var isRemoveAllMessages = false
    @AppStorage("message") var message: String = ""
    
    @AppStorage("messages") var messages: [SpeechItem] = []
    
    @AppStorage("lastUpdatedSpeech")
    var lastUpdatedSpeech = Date.distantFuture.timeIntervalSince1970

    var body: some View {
        ScrollView {
            
//MARK: - Message recording/editing panel
            VStack {
                let lastUpdatedStamp = Date(timeIntervalSince1970: lastUpdatedSpeech)
                Text("\(String.starting) \(lastUpdatedStamp.formatted(.relative(presentation: .named).locale(Locale(identifier: locale))))").opacity(0.5)
                Text(Date.now.formatted()).opacity(0.4).fontWeight(.light)
                TextField(String.turnOnMicMessage, text: $message, axis: .vertical)
            }
            .overlay(alignment: .topTrailing) {
                sendMessageButton()
            }
            .customTextModifier
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(isRecording ? .yellow.opacity(0.4) : .cyan.opacity(0.6), lineWidth: 0.8))
            
//MARK: - Start speech recognize and transcript
            if isRecording {
                VStack {
                    Text(String.recognizing).opacity(0.7).fontWeight(.light).foregroundStyle(.cyan)
                    Text(speechRecognizer.transcript)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            
//MARK: - List of messages
            ForEach(messages) { item in
                if !item.message.isEmpty {
                    VStack(alignment: .center) {
                        Text(item.date).opacity(0.5).fontWeight(.light)
                            .padding(EdgeInsets(top: 5, leading: 60, bottom: 5, trailing: 60))
                        Text(item.message)
                    }
                    .overlay(alignment: .topTrailing) {
                        copyMessageButton(of: item)
                    }
                    .overlay(alignment: .topLeading) {
                        removeMessageButton(of: item)
                    }
                    .customTextModifier
                }
            }
        }
        
//MARK: - Manage block
        .toolbar {speechToolbar()}
        .padding(20)
        .navigationModifier(String.speechRecognizer)
        .onDisappear {speechRecognizer.stopTranscribing()}
    }
}
