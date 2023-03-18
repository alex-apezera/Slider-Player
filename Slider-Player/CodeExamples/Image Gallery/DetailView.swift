//
//  DataView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 28.04.2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let item: Item
    let date: Date?
    let location: CLLocationCoordinate2D?
    
    @State var name: String = "Placemark not defined"

    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private func nameOfPlace(_ location: CLLocationCoordinate2D) -> String {
        let coordinate = CLLocation(latitude: location.latitude, longitude: location.longitude)
        coordinate.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error(DetailView): Placemark not defined", error ?? "nil")
                return }
            name = placemark.name ?? "Placemark not defined"
            print(name)
        }
        return name
    }

    var body: some View {
        
        VStack {
            
            if let date = date {
                Text("\(date, formatter: Self.dateFormat)")
                    .padding(8)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    .padding(8)
                
            }
            
            if let location = location {
                Text(nameOfPlace(location))
                    .padding(8)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                    .padding(8)
            }
            
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10  )
                /// Место для вставки кода захвата изображения
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "grizzly", withExtension: "jpg") {
            DetailView(item: Item(url: url), date: Date(), location: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 55.7209,
                    longitude: 37.5820),
                latitudinalMeters: .init(10000),
                longitudinalMeters: .init(10000)).center)
        }
    }
}
