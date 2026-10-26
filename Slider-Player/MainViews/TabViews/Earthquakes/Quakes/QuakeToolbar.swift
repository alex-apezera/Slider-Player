/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The toolbar for the Quakes view.
*/

import SwiftUI

extension Quakes {

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(provider.quakes.map { $0.code })
                    } else {
                        selection = []
                    }
                }
                DeleteButton {
                    deleteQuakes(for: selection)
                }
                .disabled(isLoading || selection.isEmpty)
            } else {
                RefreshButton {
                    Task {
                        await fetchQuakes()
                    }
                }
            }

        }
        ToolbarItem(placement: .topBarLeading) {
            EditingButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
        ToolbarItem(placement: .principal) {
            if !(editMode == .active) {
                ToolbarStatus(
                    title: .quakes,
                    isLoading: isLoading,
                    lastUpdated: lastUpdated,
                    count: provider.quakes.count
                )
            } else  {Text(title)}
        }
    }
}
