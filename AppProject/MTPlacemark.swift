//
//  MTPlacemark.swift
//  AppProject
//
//  Created by Mia Troiano on 4/17/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class MTPlacemark {
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
