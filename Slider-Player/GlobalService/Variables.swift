//
//  Variables.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 02.10.2024.
//

import SwiftUI

//MARK: - Check device is iPad (or iPhone)
var iPadDevice: Bool { UIDevice.current.userInterfaceIdiom == .pad }

//MARK: - Document directory
var documentDirectory: URL? {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! }

//MARK: - Path to store MetaData in FileManager
var metaURL = documentDirectory?.appendingPathComponent("metaData.json")

//MARK: - Locale for App
var locale: String { UserSettings().localeItem == .russian ? .ruLocale : .enLocale }

var localeRu: Bool { UserSettings().localeItem == .russian ? true : false }

let idLength: Int = 8
