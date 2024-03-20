//
//  Location.swift
//
//
//  Created by Lukáš Spurný on 18.03.2024.
//

import Foundation
import CoreLocation.CLLocation

public extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}

