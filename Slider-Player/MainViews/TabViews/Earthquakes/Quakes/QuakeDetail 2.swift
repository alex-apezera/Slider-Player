/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The view which displays map with location, the magitude, rendered location name, date/time, coordinates of an earthquake.
 Also available weather conditions.
 */

import SwiftUI
import CoreLocation

struct QuakeDetail: View {
    var quake: Quake
    @EnvironmentObject private var quakesProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    @State var openWeatherView = false
    @State var weatherApiView = false
    @State private var strength = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                if let location = self.location {
                    QuakeDetailMap(location: location, tintColor: quake.color)
                        .ignoresSafeArea(.container)
                }
                VStack {
                    
                    QuakeMagnitude(quake: quake)
                   
                    HStack {
                        if #available (iOS 18.0, *) {
                            //Show text shaking with quake magnitude
                            Text(quake.place)
                                .textRenderer(QuakeRenderer(moveAmount: strength))
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {strength = quake.magnitude}
                                }
                        } else {
                            //Plain text
                            Text(quake.place)
                        }
                    }.font(.title3).bold().foregroundStyle(.primary)

                    Text(quake.time.formatted(customDateStyle()))
                        .foregroundStyle(.secondary).bold()
                    
                    Text("\(TimeZone.current)").font(.footnote).fontWeight(.ultraLight)
                    
                    HStack {
                        if let location = self.location {
                            Text("\(.latitude): \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                            Text("\(.longitude): \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                            ElevationView(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        }
                    }
                    .foregroundStyle(.tertiary).fontWeight(.light).font(.footnote)
                    .padding(.bottom, 15)
                }.padding(5)
            }
            if openWeatherView {
                let coordinate = CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
                weatherInfo(for: coordinate)
            }
            if weatherApiView {
                let coordinate = CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
                WeatherApiView(coordinates: String(coordinate.latitude) + "," + String(coordinate.longitude), viewingDetails: $weatherApiView).environmentObject(WeatherViewModel())
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
        .toolbar { ToolbarWeather(openWeatherView: $openWeatherView, weatherApiView: $weatherApiView).weatherButtons() }
        .navigationBarTitle(String.quakePlace)
        .navigationBarTitleDisplayMode(.inline)
    }
}
