//
//  Extensions.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.04.2023.
//

import Foundation
import SwiftUI
import UIKit
import MapKit
import Contacts

//MARK: Fetch data from Map location

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}

extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}

//MARK: Double Fomatter for Bubble

extension Double {
    func describeAsFixedLengthString(integerDigits: Int = 2, fractionDigits: Int = 2) -> String {
        self.formatted(
            .number
                .sign(strategy: .always())
                .precision(
                    .integerAndFractionLength(integer: integerDigits, fraction: fractionDigits)
                )
        )
    }
}

//MARK: - Data Formatter

func dateString(for date: Date?) -> String {
    var dateFormatted = ""
    
    // Create Date
    if let date = date {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Set Locale
        dateFormatter.locale = Locale(identifier: "en")

        // Convert Date to String
        dateFormatted = dateFormatter.string(from: date) // January 23, 2023 at 9:40 PM
    }
    return dateFormatted
}

extension DateComponentsFormatter {
    static let abbreviated: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    static let pozitional: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.pozitional")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

//MARK: - UserDefaults + Codable

extension UserDefaults {
    func storeCodable<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func retrieveCodable<T: Codable>(for key: String) -> T? {
        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

//MARK: UIView -> UIImage

extension UIView {
    // This is the function to convert UIView to UIImage (need import UIKit)
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//MARK: Image -> UIImage

// Converting SwiftUI Image to UIImage
extension View {
    
    public func toUIImage() -> UIImage {
        
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
#if targetEnvironment(macCatalyst)
        
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
#else
        
        var window: UIWindow? {
            guard let scene = UIApplication.shared.connectedScenes.first,
                  let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                  let window = windowSceneDelegate.window else {
                return nil
            }
            return window
        }
        
        if let window = window, let rootViewController = window.rootViewController {
            var topController = rootViewController
            while let newTopController = topController.presentedViewController {
                topController = newTopController
            }
            topController.view.insertSubview(controller.view, at: controller.view.subviews.count)
        } else {
            print("cant access window")
        }
        
#endif
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        // here is the call to the function that converts UIView to UIImage: `.asImage()`
        guard let image = controller.view.largeContentImage else { return UIImage(systemName: "person") ?? UIImage() }
        controller.view.removeFromSuperview()
        return image
    }
}

// reading the saved image from userDefaults
func getSavedImage(for size: String) -> Image? {
    if let data = UserDefaults.standard.data(forKey: size) {
        if let image = UIImage(data: data) {
            return Image(uiImage: image)
        }
    }
    return nil
}

extension Image {
    
    func toData()-> Data {
        return self.toUIImage().jpegData(compressionQuality: 1)!
    }
    
    func save(for name: String) {
        UserDefaults.standard.setValue(self.toData(), forKey: name)
    }
}

//MARK: Check incorrect characters in text

func notAllowedCharacters(in text: String) -> Int {
    
    let allowedCharacters = " qwertyuiopasdfghjklzxcvbnmйцукенгшщзхъфывапролджэёячсмитьбю"
    var countOfAllowedCharacters = 0
    
    for character in text {
        if (allowedCharacters + allowedCharacters.uppercased()).contains(character) {
            countOfAllowedCharacters += 1
        }
    }
    return text.count - countOfAllowedCharacters
}

//MARK: UserTextField with Alert

struct UserTextField: View {
    
    let prompt: String
    @Binding var text: String
    @State var showAlert: Bool = false
    
    var body: some View {
        TextField(prompt, text: $text) {isChanged in
            let incorrectCharacters = notAllowedCharacters(in: text)
            if !isChanged && incorrectCharacters != 0 {
                showAlert = true
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Incorrect \(notAllowedCharacters(in: text)) character(s) in \(prompt), try again! "))
        }
    }
}
