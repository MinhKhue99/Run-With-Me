//
//  CLLocationCoordinate2D.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 15/03/2023.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
