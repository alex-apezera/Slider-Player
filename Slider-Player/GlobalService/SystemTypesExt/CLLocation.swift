//
//  CLLocation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import CoreLocation

//MARK: - Fetch data from Map location

extension CLLocation {
    @available(iOS, deprecated: 26.0)
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }

    @available(iOS, deprecated: 26.0)
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
