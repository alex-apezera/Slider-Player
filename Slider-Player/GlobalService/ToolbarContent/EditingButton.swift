/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The edit button of the app.
*/

import SwiftUI

struct EditingButton: View {
    @Binding var editMode: EditMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                if editMode == .active {
                    action()
                    editMode = .inactive
                } else {
                    editMode = .active
                }
            }
        } label: {
            Image(systemName: editMode == .active ? "pencil.slash" : "pencil")
                .foregroundColor(editMode == .active ? .red : .accentColor)
        }
    }
}
