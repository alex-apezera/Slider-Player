//
//  MusicToolBar.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 21.05.2024.
//

import SwiftUI

extension MusicListView {
    @ToolbarContentBuilder
    func musicToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {

//MARK: - Music selection
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(manager.pieces.map {$0.id})
// <equal above line:>  selection = Set(manager.musicFiles.map {$0.path()})
                    } else {
                        selection = []
                    }
                }
            }
//MARK: - File import
            Button {
                isFileImporterShown.toggle()
            } label: {
                Image(systemName: "square.and.arrow.down")
            }
            .padding()
            .fileImporter(isPresented: $isFileImporterShown, allowedContentTypes: [.audio], allowsMultipleSelection: true) { result in
                do {
                    let url = try result.get().first!
                    manager.saveMusicFile(url: url)
                    completePieces()
                    lastUpdatedMusicFiles = Date().timeIntervalSince1970
                } catch {
                    print("Error to save misic file: ", error)
                }
            }
        }
//MARK: - Editing Mode
        ToolbarItem(placement: .topBarLeading) {
            EditingButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
 //MARK: - Bottom State String
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                manager.getMusicFiles()
                completePieces()
                lastUpdatedMusicFiles = Date().timeIntervalSince1970
            }
            Spacer()
            ToolbarStatus(title: .pieces, isLoading: isLoading, lastUpdated: lastUpdatedMusicFiles, count: manager.pieces.count)
            Spacer()
                //MARK: - Copy music files to main directory
            Button {
                copyFile = true
                copyMusicFiles(for: Array(selection))
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {copyFile = false})
            } label: {
                Image(systemName: "arrowshape.turn.up.right")
            }
            .disabled(isLoading || selection.isEmpty)
            .padding(10)
            //MARK: - Export music file
            if editMode == .inactive {
                ShareLink(item: FileManager.musicFilesDir.appendingPathComponent(exportTrack(for: Array(selection)).lastPathComponent), subject: Text(String.exportTrack)) {
                    Image(systemName: "square.and.arrow.up")
                }
                .disabled(isLoading || selection.isEmpty || selection.count > 1)
            }
            //MARK: - Delete selected files
            if editMode == .active {
                DeleteButton {
                    withAnimation {
                        deleteMusicFiles(for: Array(selection))
                    }
                }
                .disabled(isLoading || selection.isEmpty)
            }
        }
    }
}
