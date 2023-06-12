/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The list item view which displays details of a given earthquake.
With localized date-time.
*/

import SwiftUI

struct QuakeRow: View {
    var quake: Quake
    
    var body: some View {
        HStack {
            QuakeMagnitude(quake: quake)
            VStack(alignment: .leading) {
                
                Text(quake.place).font(.title3)
                
                let dateTime = quake.time.formatted(.relative(presentation: .named).locale(Locale(identifier: locale)))
                Text(dateTime).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
