/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The select button of the app which toggles between selection and deselection.
*/

import SwiftUI

enum SelectMode {
    case active, inactive

    var isActive: Bool {
        self == .active
    }

    mutating func toggle() {
        switch self {
        case .active:
            self = .inactive
        case .inactive:
            self = .active
        }
    }
}

struct SelectButton: View {
    @Binding var mode: SelectMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                mode.toggle()
                action()
            }
        } label: {
            Image(systemName: mode.isActive ? "list.bullet.rectangle.portrait" : "list.bullet.rectangle.portrait.fill")
                .foregroundStyle(Color(mode.isActive ? .orange : .blue))
        }
    }
}
