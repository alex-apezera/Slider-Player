//
//  Profile.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.04.2023.

//MARK: - Autorization and Profile with Settings

import SwiftUI

struct Profile: View {
    @Binding var start: Bool
    @Binding var goAutorization: Bool
    @State var goSettings: Bool
    
    let cr: CGFloat = 15 /// corner radius
    
    var body: some View {
        ProfileForm(start: $start, goAutorization: $goAutorization, goSettings: goSettings)
            .frame(maxWidth: iPadDevice ? 440 : 360, maxHeight: goSettings ? 600 : 180)
            .overlay(RoundedRectangle(cornerRadius: cr).stroke(lineWidth: 1.0))
            .cornerRadius(cr)
            .shadow(radius: 5)
            .background(.thickMaterial, in: RoundedRectangle(cornerRadius: cr))
            .offset(x: 0, y: iPadDevice ? -120 : goSettings ? -40 : -150)
    }
}
