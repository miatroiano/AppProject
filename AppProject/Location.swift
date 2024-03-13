//
//  Location.swift
//  AppProject
//
//  Created by Mia Troiano on 3/13/24.
//

import Foundation
import SwiftUI
import MapKit
struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
