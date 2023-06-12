/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The delete button of the app.
*/

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label(String.delete, systemImage: "trash")
        }
    }
}
