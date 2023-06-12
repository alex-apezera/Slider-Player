/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The refresh button of the app.
*/

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label(String.refresh, systemImage: "arrow.clockwise")
        }
    }
}
