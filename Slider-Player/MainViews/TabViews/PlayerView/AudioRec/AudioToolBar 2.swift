//
//  AudioToolBar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.05.2024.
//

import SwiftUI

extension AudioRecorder {
    @ToolbarContentBuilder
    func recorderToolbar() -> some ToolbarContent {
        
        ToolbarItem(placement: .topBarLeading) {
            
//MARK: - Remove all files
            Button { withAnimation {
                isRemoveAll = true
            }
            } label: {
                Image(systemName: "trash")
            }
            .actionSheet(isPresented: $isRemoveAll) {
                ActionSheet(
                    title: Text(String.actionText),
                    message: Text(String.actionMessage),
                    buttons:[
                        .destructive(Text(String.actionOK), action: removeAllAudios),
                        .cancel(Text(String.cancel))
                    ]
                )
            }
            .disabled(audios.isEmpty)
        }
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            
 //MARK: - Record and store audio file
            Button {
                recordAndStoreAudio(record: &record, recorder: &recorder, audios: &audios)
                audiosCount = audios.count
            } label: {
                ZStack{
                    Circle()
                        .fill(Color.red)
                        .frame(width: 30, height: 30)
                    if record {
                        Circle()
                            .stroke(Color.orange, lineWidth: 4)
                            .frame(width: 40, height: 40)
                            .blinking()
                    }
                }
            }
        }
    }
}
