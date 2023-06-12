//
//  autorization.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.10.2024.
//
//MARK: - Enter in App
/// see  UserAutentification

import SwiftUI
extension ProfileForm {
    
    @ViewBuilder var autorization: some View {
        
        //MARK: - Autorization
        VStack {
            Text(String.autorization).fontWeight(.bold).font(.uppercaseSmallCaps(.title3)()).opacity(0.5)
            if !editPassword {
                //MARK: - Enter Login and Password
                HStack {
                    Text(String.login).font(.callout).opacity(0.7)
                    Spacer()
                }
                TextField(String.enterLogin, text: $user.userLogin) { isChanged in
                    frameColorLogin = isChanged ? Color(.systemYellow) : Color(.systemGreen)
                }
                .textFieldModifier
                .onAppear {frameColorLogin = user.userLogin.isEmpty ? Color(.systemRed) : Color(.systemGreen)}
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(user.userLogin.isEmpty ? Color(.systemRed) : frameColorLogin, lineWidth: 1.2))
                HStack {
                    Text(verbatim: isPasswordCorrect ? .swipeToEdit : .passwordText).font(.callout).opacity(0.7)
                    //MARK: -  Manage new password
                    Spacer()
                    
                    Button { withAnimation {editPassword = isPasswordCorrect ? true : false} }
                    label: {
                        Image(systemName: isPasswordCorrect ? "pencil" : "pencil.slash")
                            .foregroundStyle(isPasswordCorrect ? .green : .red)
                    }
                    //MARK: - Show (unencrypted) pasword
                    Button { withAnimation {showPassword.toggle()} }
                    label: { Image(systemName: showPassword ? "eye.slash" : "eye") }
                }
                //MARK: - Enter password
                if showPassword {
                    TextField(String.enterPassword, text: $password)
                        .textFieldModifier
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke( frameColorPassword, lineWidth: 1.2))
                        .onSubmit { withAnimation {goAutorization = false} }
                } else {
                    SecureField(String.enterPassword, text: $password)
                        .textFieldModifier
                        .focused($isFocused)
                        .onAppear { isFocused = true }
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke( frameColorPassword, lineWidth: 1.2))
                        .onSubmit { withAnimation {goAutorization = false} }
                }
            } else {
                //MARK: - Edit password
                EditText(editText: $editPassword, text: user.$userPassword, title: .editPassword, prompt: .enterNewPassword)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(String.alertText), message: nil,
                  dismissButton: .cancel(Text(String.cancel)))
        }
        .autocorrectionDisabled()
        .padding(.bottom, 10)
    }
}

