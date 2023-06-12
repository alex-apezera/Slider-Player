/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The toolbar for the Quakes view.
*/

import SwiftUI

extension Quakes {

    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(provider.quakes.map { $0.code })
                    } else {
                        selection = []
                    }
                }
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            EditingButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    await fetchQuakes()
                }
            }
            Spacer()
            ToolbarStatus(
                title: .quakes,
                isLoading: isLoading,
                lastUpdated: lastUpdated,
                count: provider.quakes.count
            )
            Spacer()
            if editMode == .active {
                DeleteButton {
                    deleteQuakes(for: selection)
                }
                .disabled(isLoading || selection.isEmpty)
            }
        }
    }
}
