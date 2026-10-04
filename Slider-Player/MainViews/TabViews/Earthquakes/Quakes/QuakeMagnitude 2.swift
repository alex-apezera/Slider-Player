/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view which displays the magitude of an earthquake.
*/

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title)
                    .bold()
                    .foregroundStyle(quake.color)
            }
    }
}
