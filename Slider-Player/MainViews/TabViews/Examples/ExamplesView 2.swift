//
//  ExamplesView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 01.05.2023.
//
// The Application uses codes borrowed from various sources, forums of programmers, tutorials.

import SwiftUI

struct ExamplesView: View {
    @Binding var backToLaunchView: Bool
        
    @AppStorage("lightsOn") var lightsOn: Bool = false
    @StateObject var dataModel = DataModel()
    @State var showWeather = false
    @StateObject var weatherVM = WeatherViewModel()
    @State var webUrl: String = .webUrlExample

    var body: some View {
        List {
            
            Button { withAnimation {
                backToLaunchView = false }
            } label: {
                Label(String.homePage, systemImage: "house")
                    .underline(false, color: .clear)
            }
            
            //MARK: - Show Weather
            if #available(iOS 17.0, *) {
                if iPadDevice {
                    NavigationLink(destination: WeatherApp()) {
                        Label(String.weather, systemImage: "thermometer.variable.and.figure")
                            .underline(false, color: .clear)
                    }
                    
                } else {
                    Button { withAnimation {
                        showWeather.toggle() }
                    } label: {
                        Label(String.weather, systemImage: "thermometer.variable.and.figure")
                            .underline(false, color: .clear)
                    }
                    .sheet(isPresented: $showWeather) {
                        WeatherApp()
                    }
                }
            }
            //MARK: - Show Current location and Weather
            NavigationLink(destination: CurrentLocation()) {
                Label(String.currentLocation, systemImage: "location")
            }
            //MARK: - MAP search experience
            NavigationLink(destination: MapView(index: 0, hideSearchButton: true).environmentObject(MetaDataModel())) {
                Label(String.mapSearch, systemImage: "map")
            }
            //MARK: - Loading Web content from QR scanner
            NavigationLink(destination: WebContentView(webUrl: webUrl)) {
                Label(String.webContent, systemImage: "network")
            }
            
            //MARK: - QR code generator
            NavigationLink(destination: QRCodeGeneratorView(webUrl: $webUrl)) {
                Label(String.qrCodeGenerator, systemImage: "qrcode")
            }
            //MARK: - QR code scanner
            NavigationLink(destination: QRScannerView(scanUrl: $webUrl)) {
                Label(String.qrCodeScanner, systemImage: "qrcode.viewfinder")
            }
            //MARK: - Photo gallery example
            NavigationLink(destination: GridView()
                .environmentObject(dataModel)) {
                    Label(String.imagesGallery, systemImage: "square.grid.3x3.square")
                }
            //MARK: - Bubble level detector
            NavigationLink(destination: BubbleLevel()
                .environmentObject(MotionDetector(updateInterval: 0.02).started())) {
                    Label(String.levelDetector, systemImage: "button.programmable.square")
                }
            //MARK: - Toggle light
            NavigationLink(destination: LightView()) {
                Label(String.toggleLights, systemImage: lightsOn ? "sun.max.fill" : "moon.fill")
            }
            //MARK: - Gesture experience
            NavigationLink(destination: GesturesMenu()) {
                Label(String.gestureExperience, systemImage: "dot.circle.and.hand.point.up.left.fill")
            }
            //MARK: - Sene storage experience
            NavigationLink(destination: SceneStore()) {
                Label(String.sceneStorage, systemImage: "square.and.arrow.down")
            }
            //MARK: - NavigationSplitView experience
            NavigationLink(destination: Navigation()) {
                Label(String.navigationSplit, systemImage: "doc.on.doc")
            }
            //MARK: - Custom types experience
            NavigationLink(destination: CustomTypes()) {
                Label(String.showRecipes, systemImage: "pin")
            }
        }
        .font(.system(size: 20))
        .navigationModifier(String.more)
    }
}
