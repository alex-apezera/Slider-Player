//
//  AlertTextField.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.08.2024.
//

import SwiftUI

struct AlertTextField: View {
    
    let prompt: String
    @Binding var text: String
    @State var showAlert: Bool = false
    
//MARK: TextField with Alert
    var body: some View {
        TextField(prompt, text: $text) {isChanged in
            let incorrectCharacters = notAllowedCharacters(in: text)
            if !isChanged && incorrectCharacters != 0 {
                showAlert = true
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("\(.incorrect)\(notAllowedCharacters(in: text))\(.characters)\(prompt), \(.tryAgain)"),                 dismissButton: .cancel(Text(String.cancel)))
        }
    }
}
