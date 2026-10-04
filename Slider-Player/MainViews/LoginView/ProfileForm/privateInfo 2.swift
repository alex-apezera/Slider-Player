//
//  privateInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.10.2024.
//
//MARK: - Profile: avatar + Info

import SwiftUI
extension ProfileForm {
    @ViewBuilder var privateInfo: some View {
        
        Text(String.profile).fontWeight(.bold).font(.uppercaseSmallCaps(.title3)()).opacity(0.5)
        
        //MARK: - Avatar
        EditableCircularProfileImage(viewModel: viewModel)
        
        //MARK: - Enter user info
        VStack(alignment: .leading) {
            
            HStack {
                Text(String.firstName).opacity(0.4)
                AlertTextField(prompt: String.enterFirstName, text: $user.firstName)/// use test of correct input
            }
            HStack {
                Text(String.lastName).opacity(0.4)
                AlertTextField(prompt: String.enterLastName, text: $user.lastName)/// use test of correct input
            }
            if editAboutMe {
                EditText(editText: $editAboutMe, text: $user.aboutMe, title: .addInfo, prompt: .enterAddInfo)
            } else {
                Text(user.aboutMe).foregroundStyle(.primary)
                    .onTapGesture {editAboutMe = true}
                    .padding(.vertical, 3)
            }
        }
    }
}
