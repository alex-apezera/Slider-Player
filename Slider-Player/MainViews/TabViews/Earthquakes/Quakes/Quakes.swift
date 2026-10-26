/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The views of the app, which display details of the fetched earthquake data.
*/

import SwiftUI

struct Quakes: View {
    @StateObject var provider = QuakesProvider()
    @AppStorage("quakesCount") var quakesCount = 0

    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    @State var error: QuakeError?
    @State var hasError = false
    
    var body: some View {
        List(selection: $selection) {
            ForEach(provider.quakes) { quake in
                NavigationLink(destination: QuakeDetail(quake: quake).environmentObject(provider)) {
                    QuakeRow(quake: quake)
                }
            }
            .onDelete(perform: deleteQuakes)
        }
        .onChange(of: selection) { _, newValue in
            print(#function, selection)
        }
        .toolbar {toolbarContent}
        .environment(\.editMode, $editMode)
        .refreshable {
            await fetchQuakes()
        }
        .task {
            await fetchQuakes()
        }
    }
}

