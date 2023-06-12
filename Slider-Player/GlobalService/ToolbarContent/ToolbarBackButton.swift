//
//  ToolbarBackButton.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 27.11.2024.
//

import SwiftUI

struct ToolbarBackButton: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    //MARK: - Body
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left").fontWeight(.semibold)
        }
    }
}

//Usage in infer View:
//in ToolbarItem:
//MARK: - Back to parent View
//            ToolbarBackButton()

//in View modifier:
//        .navigationBarBackButtonHidden()

        

