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
    @State private var error: QuakeError?
    @State private var hasError = false
    
    var body: some View {
        List(selection: $selection) {
            ForEach(provider.quakes) { quake in
                NavigationLink(destination: QuakeDetail(quake: quake).environmentObject(provider)) {
                    QuakeRow(quake: quake)
                }
            }
            .onDelete(perform: deleteQuakes)
        }
        .onChange(of: selection) { newValue in
            print(#function, selection)
        }
        .navigationModifier(title)
        .toolbar {toolbarContent()}
        .environment(\.editMode, $editMode)
        .refreshable {
            await fetchQuakes()
        }
        .task {
            await fetchQuakes()
        }
    }
}

extension Quakes {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return .capQuakes
        } else {
            return "\(selection.count) \(String.selected)"
        }
    }
    func deleteQuakes(at offsets: IndexSet) {
        provider.deleteQuakes(atOffsets: offsets)
    }
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchQuakes() async {
        do {
            try await provider.fetchQuakes()
            DispatchQueue.main.async {
                quakesCount = provider.quakes.count
                lastUpdated = Date().timeIntervalSince1970
            }
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            hasError = true
        }
    }
}
